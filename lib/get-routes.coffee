GetRoutesView = require './get-routes-view'

module.exports =

  activate: ->
    @get_routes()
    atom.workspaceView.command "get-routes:routes", => @routes()
    atom.workspaceView.command "get-routes:dispose", => @dispose()

  get_routes: ->
    exec = require("child_process").exec
    child = undefined

    child = exec(
      "bundle exec rake routes | awk '{print $1}' | egrep '^[a-z]+'",
      cwd: atom.project.getPaths(),
      (error, stdout, stderr) ->
        addPath = (str) -> "#{str}_path"
        @paths = stdout.split('\n').map(addPath).sort()
        console.log "stderr: " + stderr if stderr
        console.log "exec error: " + error  if error isnt null
    )

  routes: ->
    @getRoutesView = new GetRoutesView
    @getRoutesView.setElements(paths)

  dispose: ->
    @getRoutesView.remove()
