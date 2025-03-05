defmodule TaskifyWeb.TestLive do
  use TaskifyWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mt-16 align-text-center">
    <p class="mb-4">The New value is: {@count}</p>
    <button phx-click="add_one" tabindex="1" phx-keydown="add_one" phx-key="Enter" class="bg-brand px-4 py-1 pb-2 rounded-[4px] text-white inline-block mr-8">Add +1</button>
    <button phx-click="double" tabindex="2" phx-keydown="double" phx-key="Enter" class="bg-brand px-4 py-1 pb-2 rounded-[4px] text-white inline-block mr-8">Double</button>
    <button phx-click="slice" tabindex="3" phx-keydown="slice" phx-key="Enter" class="bg-brand px-4 py-1 pb-2 rounded-[4px] text-white inline-block mr-8">Slice twice</button>
    <.link navigate={~p"/"} class="bg-brand px-4 py-1 pb-2 rounded-[4px] text-white inline-block mr-8">Home</.link>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("add_one", _params, socket) do
    new_count = socket.assigns.count + 1
    {:noreply, assign(socket, :count, new_count)}
  end
  def handle_event("double", _params, socket) do
    new_count = socket.assigns.count * 2
    {:noreply, assign(socket, :count, new_count)}
  end
  def handle_event("slice", _params, socket) do
    new_count = socket.assigns.count / 2
    {:noreply, assign(socket, :count, new_count)}
  end
end
