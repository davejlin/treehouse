import logging

logging.basicConfig(filename='logging.log', level=logging.DEBUG)

logging.debug('hello this is debug')
logging.info('hello this is info')
logging.warning('hello this is warning')
logging.error('hello this is error')
logging.critical('hello this is critical')