# -*- coding: utf-8 -*-
from odoo import http

# class EzAceTest(http.Controller):
#     @http.route('/ez_ace_test/ez_ace_test/', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/ez_ace_test/ez_ace_test/objects/', auth='public')
#     def list(self, **kw):
#         return http.request.render('ez_ace_test.listing', {
#             'root': '/ez_ace_test/ez_ace_test',
#             'objects': http.request.env['ez_ace_test.ez_ace_test'].search([]),
#         })

#     @http.route('/ez_ace_test/ez_ace_test/objects/<model("ez_ace_test.ez_ace_test"):obj>/', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('ez_ace_test.object', {
#             'object': obj
#         })