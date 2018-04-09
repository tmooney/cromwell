task let_me_run {
    command {
        echo "I'm alive !!"
    }
    runtime {
       docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
    }
    output {
        Boolean done = true
    }
}

task aborted {
    Boolean go
    # This sleep is long on purpose: we'll check that the VM doesn't exist anymore as a proof that the job
    # was successfully aborted, but we don't want it to die on its own before that because the job ended
    command {
        echo "Abort incoming"
        sleep 1200
    }
    runtime {
       docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
    }
    output {
            Boolean done = true
   }
}

task lost_in_space {
    Boolean go
    command {
        echo "Forgotten task"
    }
    runtime {
       docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
    }
}

workflow scheduled_abort {
    call let_me_run
    call aborted { input: go = let_me_run.done }
    call lost_in_space { input: go = aborted.done }
}
