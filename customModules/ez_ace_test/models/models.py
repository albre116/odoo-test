# -*- coding: utf-8 -*-

from odoo import models, fields, api

class Course(models.Model):
    _name = 'ez_ace_test.course'

    name = fields.Char(string="Title", required=True)
    description = fields.Text()

# class ez_ace_test(models.Model):
#     _name = 'ez_ace_test.ez_ace_test'

#     name = fields.Char()
#     value = fields.Integer()
#     value2 = fields.Float(compute="_value_pc", store=True)
#     description = fields.Text()
#
#     @api.depends('value')
#     def _value_pc(self):
#         self.value2 = float(self.value) / 100