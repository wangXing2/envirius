#!/usr/bin/env bats

load test_helper

@test "on: mk empty env & activate it" {
    run nv rm --all
    [ "$status" -eq 0 ]
    run nv mk empty_env2
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]
    run nv ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]
    nv on test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "activate: mk empty env & activate it" {
    # same as in test for 'on' command
    run nv rm --all
    [ "$status" -eq 0 ]
    run nv mk empty_env2
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]
    run nv ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]
    # end of copy from test for 'on' command
    nv activate test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]
    [ "`echo $NV_OLD_PATH`" != "" ]
}
