function cp_aws
    aws sso login --profile cp-axelar-relayers
    set -gx AWS_PROFILE cp-axelar-relayers
    # Clear any explicit key vars that would override the profile
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN
end
