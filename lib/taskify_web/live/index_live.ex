defmodule TaskifyWeb.IndexLive do
  use TaskifyWeb, :live_view

  def render(assigns) do
    ~H"""
    <section
      class="h-[300px] w-[75%] absolute top-[150px] left-[50%] translate-x-[-50%] h-auto pb-12 grid place-items-center content-center"
    >
      <h1
        class="py-6 bg-white text-center w-100 text-neutral-800 font-semibold text-2xl"
      >
        Homepage
      </h1>
      <div class="h-full grid place-items-center content-start">
        <p class="text-neutral-800 mb-7">
          Stay Organized, Stay Ahead.
        </p>
        <.link
          navigate={~p"/tasks"}
          class="block px-16 py-2 pb-3 bg-brand text-white rounded-[4px] hover:bg-primary/80"
          >View your Tasks
        </.link>
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
