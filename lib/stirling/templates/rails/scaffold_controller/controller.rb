<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < Stirling::BaseController
  def create
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "\"#{human_name} was successfully created.\"" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "\"#{human_name} was successfully updated.\"" %>
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "\"#{human_name} was successfully destroyed.\"" %>
  end
end
<% end -%>
