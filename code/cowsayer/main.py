import falcon
import cowsay

import sys

class ListStream:
    def __init__(self):
        self.text = ""
    def write(self, s):
        self.text += s
    def __enter__(self):
        sys.stdout = self
        return self
    def __exit__(self, ext_type, exc_value, traceback):
        sys.stdout = sys.__stdout__  


class AnimalResource:
    def on_post(self, req, resp, animal):
        try:
            sayer = getattr(cowsay, animal)
        except AttributeError:
            resp.status = falcon.HTTP_NOT_FOUND
            resp.media = "Animal not found!\nAvailable options are %s" % "|".join(cowsay.char_names)
            return
        with ListStream() as animal_text:
            sayer(req.media['text'])
        resp.media = animal_text.text

api = falcon.API()
api.add_route('/{animal}', AnimalResource())
