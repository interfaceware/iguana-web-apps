require 'file'
require 'stringutil'
require 'node'

bm = {}
bm.config = {}
bm.app = {}

require "bedmonitor.app.listBeds"

bm.actions = {
   ["list-beds"] = bm.app.listBeds
}