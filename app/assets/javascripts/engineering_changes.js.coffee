# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

hideEnvironments = -> $("[id^=env_]").hide()
showEnvironment = (id) ->
  hideEnvironments()
  $('#env_' + id).show()

$(document).ready ->
  $('#engineering_change_environment_id').on 'change', -> showEnvironment(@value)
  $('#engineering_change_environment_id').trigger('change')
