"""
Copyright (C) 2022, DLR Institut fuer Systemdynamik und Regelungstechnik
All rights reserved.

Check url adress in links of Modelica HTML documentation for validity
python check_url_access.py [path]
"""
import importlib
import os
import sys
import ssl

from  urllib import request, error
from bs4 import BeautifulSoup

FILE_EXT = ('.mo', '.md')
URL_TYPE = ('http:', 'https:', 'mailto')
# Which HTTP errors to be considered
ERR = [400, 401, 403, 404, 406, 500, 502]

if __name__ == '__main__':

    module_dir = os.path.split(__file__)[0]
    if len(sys.argv) == 1:
        path = os.path.realpath(module_dir)
    elif len(sys.argv) > 1:
        path = sys.argv[1]

    print('Check url in', path)

    for root, _, files in os.walk(path):
        for i in files:
            if i.endswith(FILE_EXT):
                file_ = os.path.join(root, i)

                f = open(file_, 'r')
                html_doc = f.read().replace('\\"', '"')
                soup = BeautifulSoup(html_doc, 'html.parser')

                for link in soup.find_all('a'):
                    url = link.get('href')

                    if url is not None and url.startswith(URL_TYPE):
                        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64)'}
                        try:
                            req = request.Request(url, headers=headers)
                            resp = request.urlopen(
                                req,
                                timeout=10,
                                context=ssl._create_unverified_context()
                                )
                        except error.URLError as er:
                            if er in ERR:
                                print(file_, ":\n  Error:", url, ":", er.code)
                        # else:
                        #     print ('no problem with:', url)
                f.close()