process foo {
    echo true
    executor = "slurm"
    queue = "cpu_short"

    input:
    val(x) from Channel.from('')

    script:
    """
    echo "starting nextflow task"
    sleep 60
    """
}
