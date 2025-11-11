
from command_helper import *
import os
import sys

class RunExternalCmd(Generator):

  def __init__(self,v={}):
    super(RunExternalCmd,self).__init__
    self.keys = '''
           ext_cmd
           ext_cmd_extra
                 '''.split()
    pass
    
  def set_ext_cmd(self,v={}):
      return v['ext_cmd']

  def set_ext_cmd_extra(self,v={}):
      return v['ext_cmd_extra']

  def elaborate(self,v={}):
    self.ext_cmd        = self.set_ext_cmd(v)
    self.ext_cmd_extra  = self.set_ext_cmd_extra(v)

  def command(self,v):
    return self.ext_cmd + " " + self.ext_cmd_extra

# Build a command to execute 
def generate_command(v={}):
  obj = RunExternalCmd()
  obj.elaborate(v)
  return obj.command(v)
