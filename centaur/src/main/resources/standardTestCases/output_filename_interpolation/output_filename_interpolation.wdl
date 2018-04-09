task output_filename_interpolation {
    String outputPrefix = "Oops"
    String outputMain = "Upside"
    String outputSuffix = "YourHead"

    command {
        mkdir ${outputPrefix}
        echo a > ${outputMain}
        echo b > ${outputMain + "." + outputSuffix}
        echo c > ${outputPrefix}/${outputMain}.${outputSuffix}
    }

    output {
        String a = read_string(outputMain)
        String b = read_string("${outputMain}.${outputSuffix}")
        String c = read_string(outputPrefix + "/" + outputMain + "." + outputSuffix)
    }

    runtime { docker: "us.gcr.io/google-containers/ubuntu-slim:0.14" }
}

workflow output_filename_interpolation_wf {
    call output_filename_interpolation
}
