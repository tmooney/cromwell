task makeGcsFileInJes {
  command {
    echo "I am writing stuff" > out
  }

  runtime {
    docker: "us.gcr.io/google-containers/ubuntu-slim:0.14"
  }

  output {
    File outputFile = "out"
  }
}

task readGcsFileFromLocal {
  File gcsFile

  command {
    cat ${gcsFile}
  }

  runtime {
    backend: "Local"
  }

  output {
    String result = read_string(stdout())
  }
}

workflow local_gcs {
  call makeGcsFileInJes
  call readGcsFileFromLocal { input: gcsFile = makeGcsFileInJes.outputFile }
}
