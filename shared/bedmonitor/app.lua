require 'file'
require 'stringutil'
require 'node'

bedmonitor = {}
bedmonitor.app = {}

require "bedmonitor.app.listBeds"


bedmonitor.actions = {
   ["list-beds"] = bedmonitor.app.listBeds
}