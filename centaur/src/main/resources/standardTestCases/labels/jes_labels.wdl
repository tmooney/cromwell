workflow I_hope_nobody_names_workflows_like_this_as_it_seems_very_unnecessary_ {
    call MY_TASK as my_task_aliased {}
}

task MY_TASK {
  command {
    sleep 1
  }
  runtime {
    docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
    preemptible: 3
  }
}
