-- $Revision: 1.6 $
-- $Date: 2013-08-16 15:21:54 $

--
-- The dateparse module
-- Copyright (c) 2011-2012 iNTERFACEWARE Inc. ALL RIGHTS RESERVED
-- iNTERFACEWARE permits you to use, modify, and distribute this file in accordance
-- with the terms of the iNTERFACEWARE license agreement accompanying the software
-- in which it is used.
--

local wdays = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
                'Saturday', 'Sunday' }

local months = { 'January', 'February', 'March', 'April', 'May', 'June', 'July',
                 'August', 'September', 'October', 'November', 'December' }

local wdays_by_name, months_by_name = {}
if true then
   local function index_by_name(array)
      local dict = {}
      for i,name in pairs(array) do
         name = name:lower()
         dict[name] = i
         dict[name:sub(1,3)] = i  -- Abbrev.
      end
      return dict
   end
   wdays_by_name  = index_by_name(wdays)
   months_by_name = index_by_name(months)
end

-- Validate week-day names and abbreviations.
local function lookup_wday(s)
   local wday = wdays_by_name[s:lower()]
   if not wday then error('expected week-day, got "'..s..'"') end
   return wday
end

-- Translate month names and abbreviations to numbers.  E.g., Jan -> 1.
local function lookup_month(s)
   local month = months_by_name[s:lower()]
   if not month then error('expected month, got "'..s..'"') end
   return month
end

-- If we find PM (or P), we need to adjust the hour that was read.
local function fix_hour(AM,PM)
   return function(s,d)
             if s:upper() == PM then
                if d.hour ~= 12 then d.hour = d.hour + 12 end
             elseif s:upper() == AM then
                if d.hour == 12 then d.hour = 0 end
             else
                error('expected '..AM..' or '..PM..', got "'..s..'"')
             end
          end
end

-- Time zone information can be parsed and stored in the date/time
-- table.  It is not used to adjust the time value returned.
local known_tzs = {
   ACDT='+10:30', ACST='+09:30', ACT ='+08:00', ADT  ='-03:00', AEDT ='+11:00',
   AEST='+10:00', AFT ='+04:30', AKDT='-08:00', AKST ='-09:00', AMST ='+05:00',
   AMT ='+04:00', ART ='-03:00', AST ='+03:00', AST  ='+04:00', AST  ='+03:00',
   AST ='-04:00', AWDT='+09:00', AWST='+08:00', AZOST='-01:00', AZT  ='+04:00',
   BDT ='+08:00', BIOT='+06:00', BIT ='-12:00', BOT  ='-04:00', BRT  ='-03:00',
   BST ='+06:00', BST ='+01:00', BTT ='+06:00', CAT  ='+02:00', CCT  ='+06:30',
   CDT ='-05:00', CEDT='+02:00', CEST='+02:00', CET  ='+01:00', CHAST='+12:45',
   CIST='-08:00', CKT ='-10:00', CLST='-03:00', CLT  ='-04:00', COST ='-04:00',
   COT ='-05:00', CST ='-06:00', CST ='+08:00', CVT  ='-01:00', CXT  ='+07:00',
   CHST='+10:00', DFT ='+01:00', EAST='-06:00', EAT  ='+03:00', ECT  ='-04:00',
   ECT ='-05:00', EDT ='-04:00', EEDT='+03:00', EEST ='+03:00', EET  ='+02:00',
   EST ='-05:00', FJT ='+12:00', FKST='-03:00', FKT  ='-04:00', GALT ='-06:00',
   GET ='+04:00', GFT ='-03:00', GILT='+12:00', GIT  ='-09:00', GMT  ='+00:00',
   GST ='-02:00', GYT ='-04:00', HADT='-09:00', HAST ='-10:00', HKT  ='+08:00',
   HMT ='+05:00', HST ='-10:00', IRKT='+08:00', IRST ='+03:30', IST  ='+05:30',
   IST ='+01:00', IST ='+02:00', JST ='+09:00', KRAT ='+07:00', KST  ='+09:00',
   LHST='+10:30', LINT='+14:00', MAGT='+11:00', MDT  ='-06:00', MIT  ='-09:30',
   MSD ='+04:00', MSK ='+03:00', MST ='+08:00', MST  ='-07:00', MST  ='+06:30',
   MUT ='+04:00', NDT ='-02:30', NFT ='+11:30', NPT  ='+05:45', NST  ='-03:30',
   NT  ='-03:30', OMST='+06:00', PDT ='-07:00', PETT ='+12:00', PHOT ='+13:00',
   PKT ='+05:00', PST ='-08:00', PST ='+08:00', RET  ='+04:00', SAMT ='+04:00',
   SAST='+02:00', SBT ='+11:00', SCT ='+04:00', SLT  ='+05:30', SST  ='-11:00',
   SST ='+08:00', TAHT='-10:00', THA ='+07:00', UTC  ='+00:00', UYST ='-02:00',
   UYT ='-03:00', VET ='-04:30', VLAT='+10:00', WAT  ='+01:00', WEDT ='+01:00',
   WEST='+01:00', WET ='+00:00', YAKT='+09:00', YEKT ='+05:00',
   -- US Millitary (for RFC-822)
   Z='+00:00', A='-01:00', M='-12:00', N='+01:00', Y='+12:00',
}

-- Compute the tz_offset in minute given (+/-)HH:MM or (+/-)HHMM.
local function parse_tz_offset(s,d)
   local sign, hour, min = s:match('([-+])(%d%d):?(%d%d)')
   d.tz = 'UTC'..s:gsub('([-+]%d%d):?(%d%d)', '%1:%2')
   return (d.tz_offset or 0) + (sign .. (hour*60 + min))
end

-- Set tz_offset given a time zone name.
local function parse_tz(s,d)
   local offset = known_tzs[s:upper()]
   if not offset then error('expected time zone, got "'..s..'"') end
   d.tz_offset = parse_tz_offset(offset,d)
   return s:upper()
end

-- HL7 timestamps can specify very accurate time values, up to one
-- tenth of a millisecond (four decimal points).
local function parse_sec_fraction(s)
   return tonumber('.'..s)
end

-- We do not want to pass the date table to tonumber(), just the string.
local function parseint(s)
   return tonumber(s)
end

-- The known date/time format codes.  The default action is
-- parseint(), since most values are just integers, exactly as we need
-- them.
local fmt_details = {
   yy   = { '%d%d', 'year',
            function(s)
               local year = tonumber(s) + 1900
               if year < 1969 then  -- POSIX
                  year = year + 100
               end
               return year
            end };
   yyyy = { '%d%d%d%d', 'year' };
   m    = { '%d+',    'month' };
   mm   = { '%d%d',   'month' };
   mmm  = { '%a%a%a', 'month', lookup_month }; -- Abbrev month name.
   mmmm = { '%a+',    'month', lookup_month }; -- Abbrev or full month.
   d    = { '%d+',  'day' };
   dd   = { '%d%d', 'day' };
   ddd  = { '%a%a%a', 'wday', lookup_wday };
   dddd = { '%a+',    'wday', lookup_wday };
   H    = { '%d+',  'hour' };
   HH   = { '%d%d', 'hour' };
   M    = { '%d+',  'min' };
   MM   = { '%d%d', 'min' };
   S    = { '%d+',  'sec' };
   SS   = { '%d%d', 'sec' };
   ssss = { '%d+',  'sec_fraction', parse_sec_fraction };
   t    = { '%a',   'A or P',   fix_hour('A', 'P' ) };
   tt   = { '%a%a', 'AM or PM', fix_hour('AM','PM') };
   zzzz = { '[-+]%d%d:?%d%d', 'tz_offset', parse_tz_offset };
   ZZZ  = { '%a+',            'tz',        parse_tz };
   [' '] = { '%s*', 'whitespace' }; -- Allow omission.
   [','] = { '%s*,?', 'a comma' };  -- Allow omission and leading whitespace.
   w     = { '%a+', 'a word' };     -- Value ignored.
   n     = { '%d+', 'a number' };   -- Value ignored.
}

-- Splits one part of a format string off; returns that and the rest.
local function split_fmt(fmt)
   local c = fmt:match('^(%a)')
   if c then
      return fmt:match('^('..c..'+)(.*)')
   elseif #fmt > 0 then
      return fmt:sub(1,1), fmt:sub(2)
   end
end

-- Parses the string, s, according to the format, fmt.
local function parse_date(s, fmt)
   local matched, d = '', {year=1969,day=1,month=1,hour=0,min=0,sec=0}
   local function fail(what, pattern)
      if pattern then what = what..' ('..pattern..')' end
      if matched ~= '' then what = what..' after "'..matched..'"' end
      error('expected '..what..', got "'..s..'"')
   end
   while fmt ~= '' do
      local head_fmt, rest_fmt = split_fmt(fmt)
      local pattern, field, fun = unpack(fmt_details[head_fmt] or {})
      local part, rest
      if pattern then
         part, rest = s:match('^('..pattern..')(.*)')
         if not part then fail(field,head_fmt) end
         d[field] = (fun or parseint)(part,d)
         matched = matched .. part
      elseif head_fmt:find('^%a') then
         error('unknown date/time pattern: '..head_fmt)
      elseif s:sub(1,#head_fmt) ~= head_fmt then
         fail('"'..head_fmt..'"')
      else
         matched = matched .. s:sub(1,#head_fmt)
         rest = s:sub(#head_fmt + 1)
      end
      s, fmt = rest, rest_fmt
   end
   if s ~= '' then fail('nothing') end
   return d
end

-- Expands all valid combinations of a string with optional areas
-- denoted by brackets.  E.g., "a[b]" expands to { "ab", "a" }.
local function expand_fmt(s, out)
   if not out then out = {} end
   local function add_fmt(s)
      local i, j = s:find('%b[]')
      if i then
         add_fmt(s:sub(1,i-1)..s:sub(i+1,j-1)..s:sub(j+1))
         add_fmt(s:sub(1,i-1)        ..        s:sub(j+1))
      else
         out[#out+1] = s
      end
   end
   add_fmt(s)
   return out
end

-- Date/time formats for the fuzzy parser.  These patterns must be
-- structurally unambiguous.  E.g., "mm/dd/yy" will match everything
-- that "yy/mm/dd" would, including "77/10/20".  This is intentional
-- as numerical differentiation is problematic.  E.g., which pattern
-- would match "02/03/04"?
local known_fmts = {}
if true then
   local templates = {
      -- HL7 Standard
      'yyyy[mm[dd[HHMM[SS[.ssss]]]]][zzzz]',
      -- Common formats (US)
      'm/d/yy[yy][ H:MM[:SS][ tt][ ZZZ]]',
      'yyyy-m-d[ w][ H:MM[:SS][ tt][ ZZZ]]',
      '[dddd, ]mmmm d[w], yyyy[ H:MM[:SS][ tt][ ZZZ]]',
      'H:MM[:SS][ tt][ ZZZ][, dddd], mmmm d[w], yyyy',
      -- Internet Standards (relaxed; RFC-822 and RFC-1123)
      '[dddd, ]d[w] mmmm yy[yy][ HH:MM[:SS][ tt][ ZZZ]]',
      '[ddd, ]dd mmm yy[yy] HH:MM:SS zzzz',
      -- The os.date('%c') Format
      '[dddd, ]mmmm dd, H:MM[:SS][ tt] yyyy',
      -- Other common formats
      'd-mmmm-yy[yy][ H:MM[:SS][ tt][ ZZZ]]',
   }
   for _,s in pairs(templates) do
      expand_fmt(s, known_fmts)
   end
end

-- The fuzzy date/time parser.  We try all the patterns we know, until
-- we find one that matches the given string.
local function fuzzy_parse(s)
   for _,fmt in pairs(known_fmts) do
      local ok, result = pcall(parse_date, s, fmt)
      if ok then
         return result
      end
   end
   error('unknown date/time: '..s, 3)
end

-- Once we find a matching date/time pattern, we just have to ensure
-- each value (e.g., minute) is in the allowed range.  If validation
-- fails, no other patterns are tried; see the note above as to why.
local function mktime(din,s)
   local t = os.time(din)
   if not t then
      error('invalid date/time: '..s)
   end
   local dout = os.date('*t',t)
   for _,k in pairs({'sec','min','hour','day','month','year'}) do
      if din[k] ~= dout[k] then
         error('invalid '..k..', '..din[k]..', in '..s, 3)
      end
   end
   for _,k in pairs({'tz','tz_offset','sec_fraction'}) do
      if din[k] then dout[k] = din[k] end
   end
   return t, dout
end

--
-- Public API
--

dateparse = {}
function dateparse.parse(s,fmt)
   if type(s) ~= 'string' or s == '' or s == 'NULL' then
      return nil
   end
   local function strip(s)
      return s:gsub('^%s+',''):gsub('%s+$',''):gsub('%s+',' ')
   end
   s = strip(s)
   if not fmt then
      return mktime(fuzzy_parse(s), s)
   end
   fmt = strip(fmt)
   local all_errors = {}
   for i,fmt in ipairs(expand_fmt(fmt)) do
      local ok, result = pcall(parse_date, s, fmt)
      if ok then return mktime(result,s) end
      local clean_message = result:match('^.-:.-:%s*(.*)') or result
      all_errors[i] = '"'..fmt..'" '..clean_message
   end
   error('"'..s..'" does not match:\n'..
         table.concat(all_errors, '\n'), 2)
end

-- Convert a time value to a database timestamp.  Automatically
-- detects the input format, unless you specify one (fmt).
--
function string:T(fmt)
   local t = dateparse.parse(self, fmt)
   return t and os.date('%Y-%m-%d %H:%M:%S', t)
end

-- Exactly like string:T(), except that it only produces a
-- date value for a database (i.e., time is 00:00:00).
--
function string:D(fmt)
   local t = dateparse.parse(self, fmt)
   return t and os.date('%Y-%m-%d 00:00:00', t)
end

-- Convert a time value to an HL7 timestamp.  Automatically
-- detects the input format, unless you specify one (fmt).
--
function string:TS(fmt)
   local t = dateparse.parse(self, fmt)
   return t and os.date('%Y%m%d%H%M%S', t)
end

-- Shortcuts for node values.
function node:T (fmt) return tostring(self):T (fmt) end
function node:D (fmt) return tostring(self):D (fmt) end
function node:TS(fmt) return tostring(self):TS(fmt) end

return dateparse
