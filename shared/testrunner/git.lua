local isWindows = iguana.workingDir():find('\\') or false
local gitCheckInterval = 10
testrunner = testrunner or {}
testrunner.git = {}
if not testrunner.db then testrunner.db = require 'testrunner.db' end

function testrunner.git.run(R)
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql='SELECT * FROM config', live=true}
   local LastPull = RSet[1].github_commit_hash:nodeValue()
   local GitHubOAuthToken = RSet[1].github_oauth_token:nodeValue()
   --local GitUser = ''
   --local GitPass = ''
   local GitHubRepo = RSet[1].github_repo:nodeValue()
   local LocalGitRepo = RSet[1].local_git_repo:nodeValue()
   local GitJson = ''
   
   if GitHubOAuthToken ~= '' and GitHubOAuthToken ~= nil then
      GitJson = net.http.get{url='https://' .. GitHubOAuthToken .. ':x-oauth-basic@api.github.com/repos/' .. GitHubRepo .. '/commits',live=true,headers={['User-Agent']='iNTERFACEWARE Iguana'}}
   else
      GitJson = net.http.get{url='https://' .. GitUser .. ':' .. GitPass .. '@api.github.com/repos/' .. GitHubRepo .. '/commits',live=true,headers={['User-Agent']='iNTERFACEWARE Iguana'}}
   end
   
   local GitTable = json.parse{data=GitJson}
   local LatestCommit = GitTable[1].sha
   
   trace(LastPull, LatestCommit)
   if LastPull ~= LatestCommit then
      if isWindows then
         fetch = os.execute({['dir'] = '.', ['command'] = 'git', ['arguments'] = '--git-dir=' .. LocalGitRepo .. '\\.git fetch --all < NUL'})
         reset = os.execute({['dir'] = '.', ['command'] = 'git', ['arguments'] = '--git-dir=' .. LocalGitRepo .. '\\.git reset --hard origin/master'})
      else
         fetch = os.execute({['dir'] = LocalGitRepo, ['command'] = 'git', ['arguments'] = '--git-dir=' .. LocalGitRepo .. '/.git fetch --all < /dev/null'})
         reset = os.execute({['dir'] = LocalGitRepo, ['command'] = 'git', ['arguments'] = '--git-dir=' .. LocalGitRepo .. '/.git reset --hard origin/master'})
      end
      trace(fetch, reset)
      if fetch == 0 and reset == 0 then
         DB:execute{sql='UPDATE config SET github_commit_hash = ' .. DB:quote(LatestCommit), live=true}
         return {['err'] = false, ['message'] = "GIT repo synced successfully"}
      else
         return {['err'] = true, ['message'] = "Problem syncing GIT repo."} 
      end
   else
      return {['err'] = false, ['message'] = "GIT repo already up-to-date."} 
   end
end

function testrunner.git.runauto()
   if not iguana.isTest() then
      while true do
         local LastRun = "Last run: " .. os.date()
         testrunner.git.run()
         local time
         if isWindows then
            if gitCheckInterval > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
         else
            os.execute("sleep " .. tonumber(gitCheckInterval))
         end
         os.execute('echo ' .. LastRun)
      end
   end
end

return testrunner.git

--githandler.app.runauto()