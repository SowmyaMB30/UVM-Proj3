from command_helper import *
import os
import sys

class Velhvl(Generator):
  def __init__(self,v={}):
    super(Velhvl,self).__init__
    self.keys = '''
                 cmd        sim     ldflags    extra  overlay_extra cppinstall
                '''.split()

  def set_cmd(self,v={}):
    return 'velhvl'

  def set_sim(self,v={}):
    if v_val(v,'sim'):
      return '-sim '+v['sim']
    return ''

  def set_ldflags(self,v={}):
    if v_val(v,'ldflags'):
      return v['ldflags']
    return ''

  def set_extra(self,v={}):
    if v_val(v,'velhvl_extra'):
      return v['velhvl_extra']
    return ''

  def set_overlay_extra(self,v={}):
    if v_val(v,'velhvl_overlay_extra'):
      return v['velhvl_overlay_extra']
    return ''

  def elaborate(self,v={}):
    self.cmd                     = self.set_cmd(v)      
    self.sim                     = self.set_sim(v)      
    self.ldflags                 = self.set_ldflags(v)  
    self.extra                   = self.set_extra(v)    
    self.overlay_extra           = self.set_overlay_extra(v)
    self.cppinstall              = self.set_cppinstall(v)
