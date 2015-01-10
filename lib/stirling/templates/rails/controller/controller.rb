<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Controller < Stirling::BaseController
<% actions.each do |action| -%>
  def <%= action %>
  end
  <%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>
