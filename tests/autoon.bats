#!/usr/bin/env bats

load test_helper

@test "autoon: file with explicity entered env" {
    if [ -e ./.envirius ]; then
        rm ./.envirius
    fi
    run nv autoon test_env1
    assert_success

    # file should be created
    [ -e ./.envirius ]
    # file should content environment name
    [ "`cat ./.envirius`" = "test_env1" ]
    rm ./.envirius
}

@test "autoon: show help if env not activated, file not created" {
    if [ -e ./.envirius ]; then
        rm ./.envirius
    fi
    run nv autoon
    assert_success

    # file should not be created
    [ ! -e ./.envirius ]
    [ "${lines[0]}" = "`bold Usage`: nv autoon [<env-name>]" ]
    [ "${lines[1]}" = "`bold Description`: Mark current directory for environment auto activating" ]
    [ "${lines[2]}" = "    If environment's name is not entered then used current" ]
    [ "${lines[3]}" = "    (active) environment. If environment is not activated" ]
    [ "${lines[4]}" = "    then environment's name is required." ]
}

@test "autoon: file with activated environment name" {
    if [ -e ./.envirius ]; then
        rm ./.envirius
    fi
    nv mk empty_env
    nv on empty_env
    nv autoon
    # file should be created
    [ -e ./.envirius ]
    # file should content environment name
    [ "`cat ./.envirius`" = "empty_env" ]
    rm ./.envirius
}
