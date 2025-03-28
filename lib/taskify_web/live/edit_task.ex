defmodule TaskifyWeb.EditTaskLive do
  use TaskifyWeb, :live_view

  alias Taskify.Task
  alias Taskify.Tasks

  def render(assigns) do
    ~H"""
        <section
      class="w-[75%] relative top-0 left-[50%] translate-x-[-50%] shadow-[#ddd] h-auto pb-12 shadow-lg"
    >
      <h1
        class="py-4 bg-primary text-center w-100 text-white font-semibold text-2xl"
      >
        Update Task
      </h1>

      <.simple_form :let={f} for={@changeset} action={~p"/tasks/#{@tasks}/edit"} method="put" class="pt-8 px-10">
          <.input field={f[:task]} type="text" label="Task*"
            class="border-0 p-0 px-1 border-b-2 focus:outline-none focus:border-0 focus:px-2 w-[80%]" required
          />
      <:actions>
          <.link href="/" class="py-1 text-primary rounded-sm flex items-center gap-x-1 underline">Go Back</.link>
          <.button phx-disable-with="Updating task..." class="py-1 px-6 text-white rounded-sm flex items-center gap-x-1" data-confirm="Confirm to update">Update Now</.button>
      </:actions>
      </.simple_form>
    </section>
    """
  end

  def mount(_params, session, socket) do
    user_id = session["user_id"]
    tasks = Tasks.list_tasks(user_id);
    {:ok, assign(socket, changeset: Task.changeset(%Task{}, %{}), tasks: tasks)}
  end
end
