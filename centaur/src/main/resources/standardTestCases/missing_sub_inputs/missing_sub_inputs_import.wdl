task head {
  File inputFile

  command {
     head ${inputFile}
  }
  output {
    String headOut = read_string(stdout())
  }
  runtime { docker: "us.gcr.io/google-containers/ubuntu-slim:0.14" }
}

workflow missing_inputs_sub_wf {
    File f
    call head { input: inputFile = f }
    output {
      head.headOut
    }
}
