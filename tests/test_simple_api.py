# -*- coding: utf-8 -*-

import unittest
from simple_api import app

class TesSimpleApi(unittest.TestCase):

    def setUp(self):
        app_client = app.test_client()
        self.response = app_client.get('/')

    def test_get(self):
        self.assertEqual(200, self.response.status_code)

    def test_response(self):
        self.assertEqual('{"message": "This is a Simple API! Uhhhuuulll...", "status": "OK"}', self.response.data.decode('utf-8'))

    def test_content_type(self):
        self.assertIn('application/json', self.response.content_type)
