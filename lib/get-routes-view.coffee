{SelectListView} = require 'atom-space-pen-views'

module.exports =
  class GetRoutesView extends SelectListView
   initialize: ->
     super
     @addClass('overlay from-top')
     atom.workspaceView.append(this)
     @focusFilterEditor()

   viewForItem: (item) ->
     "<li>#{item}</li>"

   confirmed: (item) ->
     editor = atom.workspace.getActiveTextEditor()
     editor.insertText("#{item}")
     this.remove()

   setElements: (list) ->
     @setItems(list)
