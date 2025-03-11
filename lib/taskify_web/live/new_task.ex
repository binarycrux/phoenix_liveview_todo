defmodule TaskifyWeb.NewTaskLive do
  use TaskifyWeb, :live_view

  alias Taskify.Repo
  alias Taskify.Task

  def render(assigns) do
    ~H"""
    <section
      class="w-[75%] relative top-0 left-[50%] translate-x-[-50%] shadow-[#ddd] h-auto pb-12 shadow-lg"
    >
      <h1
        class="py-4 bg-primary text-center w-100 text-white font-semibold text-2xl"
      >
        Just Do It!
      </h1>

      <.simple_form :let={f} for={@changeset} action={~p"/tasks"} class="pt-8 px-10">
          <.input field={f[:task]} type="text" label="Add a new task*"
            placeholder="Add here..."
            class="border-0 p-0 px-1 border-b-2 focus:outline-none focus:border-0 focus:px-2 w-[80%]" required
          />
      <:actions>
          <.button phx-disable-with="Creating task..." class="py-1 px-6 block text-white rounded-sm"><div class="flex items-center gap-x-1">
          Add
          </div>
          </.button>
      </:actions>
      </.simple_form>
      <div class="mt-10 px-10 grid gap-y-3 w-[100%]">
        <p class="font-semibold text-xl text-neutral-800 flex justify-between">
        <span>Available Tasks</span>
        <span>Actions</span>
        </p>
        <!-- Loop through the array of the todos from the db -->
    <%= for {task, index} <- Enum.with_index(@tasks) do %>
          <div class="task-item flex justify-between w-full">
            <%= if task.status == "pending" do %>
            <p class="flex gap-x-2 border-b-[1px] border-[#eee] py-1"><%= index + 1 %>. <%= String.capitalize(task.task) %> - status: <span class="text-orange-400 italic flex items-center">pending..</span></p>
              <% else %>
              <p class="flex gap-x-2 border-b-[1px] border-[#eee] py-1"><%= index + 1 %>. <span class="line-through text-neutral-600"><%= String.capitalize(task.task) %></span> - status: <span class="text-green-700 italic flex items-center">done</span></p>
              <% end %>
            <div class="flex gap-x-8 items-center flex-shrink-0">
              <%= if task.status == "pending" do %>
              <span class="text-green-700 flex gap-x-1 items-center cursor-pointer">
        <.link href={~p"/tasks/#{task.id}"} method="put" class="underline">
          Done
        </.link>
              </span>
              <% else %>
              <span class="text-orange-400 flex gap-x-1 items-center cursor-pointer">
              <.link href={~p"/tasks/#{task.id}"} method="put" class="underline">
          Undo
        </.link>
              </span>
              <% end %>
              <.link class="text-neutral-700 underline cursor-pointer" navigate={~p"/tasks/#{task}/edit"}>Edit</.link>
              <.link href={~p"/tasks/#{task.id}"} method="delete" data-confirm="Confirm to delete this task" class="text-red-700 cursor-pointer underline">Delete
        </.link>
            </div>
          </div>
        <% end %>
          </div>
    </section>
    """
  end
  def mount(_params, _session, socket) do
    tasks = Repo.all(Task)
    {:ok, assign(socket, changeset: Task.changeset(%Task{}, %{}), tasks: tasks)}
  end

end
