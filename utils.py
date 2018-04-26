import logging
import re

def get_gender(detector_instance, author):
    """ detector_instance is an instance of gender-guesser's gender.Detector().
        author is a dict from a record in the mongo collection dat.crossref. It
        may have a key with author's given name-- `given`. If it does, this
        function will estimate the gender of the name. It will return one of
        several possible result codes:
            - unknown-data_failure
            - unknown-no_first_name
            - unknown-single_character_name
            - unknown-initials_only
            - unknown-estimation_failure
            - any result possible from the detector_instance, except unknown.
    """
    if not isinstance(author, dict):
        return 'unknown-data_failure'

    try:
        if 'given' not in author or len(author['given']) == 0:
            return 'unknown-no_first_name'
        name = author['given'].split(' ')[0] # Take only first word

        if len(name) == 1:
            return 'unknown-single_character_name'

        name_sans_initials = re.sub(r'([\w\W]{1}[.]{1})', '', name)
        if not len(name_sans_initials):
            return 'unknown-initials_only'

        gender_estimate = detector_instance.get_gender(name)
        if gender_estimate == 'unknown':
            return 'unknown-estimation_failure'

        return gender_estimate

    except Exception, e:
        logging.info('Was working on author string: ', str(author))
        logging.exception(e)
        return 'unknown-code_failure'

def set_gender(collection, record_id, genders):
    """ Sets `author-genders` key for the record_id in mongo's dat.crossref. 
    """
    collection.update(
        {"_id": record_id},
        {"$set":
            {"author-genders": genders}
        }
    )

def get_cursor(collection):
    """ Gets cursor pointing at records without the field 'author-genders'.
        Returns True and the cursor if cursor has at least 1 records. Otherwise
        returns False and None. 
        Much faster than using .count() on a large cursor.
    """
    c = collection.find({
        'author-genders' : { '$exists' : False },
        'author' : {'$exists' : True}
        })

    counter = 0
    for record in c:
        c.rewind()
        # If you're in this loop there's something in the cursor
        return {'empty' : False, 'cursor' : c}
    return {'empty' : True, 'cursor' : c}
