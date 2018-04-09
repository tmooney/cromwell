
workflow subhello {
  Array[String] greeting_pieces

  call hello {
    input: inputs = greeting_pieces
  }

  String salutation_length = length(hello.out)

  # Neither the call output nor the declaration should be considered outputs to the subworkflow
}

task hello {
  Array[String] inputs

  command {}

  runtime {
    docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
  }
  output {
    Array[String] out = inputs
  }
}
