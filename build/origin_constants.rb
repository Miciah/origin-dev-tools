#
# Global definitions
#

# Fedora 16 image
AMI = {"us-east-1" =>"ami-0316d86a"}

# Fedora 17 image
#AMI = {"us-east-1" =>"ami-2ea50247"}

TYPE = "m1.large"
KEY_PAIR = "libra"
ZONE = 'us-east-1d'

DEVENV_WILDCARD = "oso-fedora_*"
DEVENV_STAGE_WILDCARD = "oso-fedora-stage_*"
DEVENV_CLEAN_WILDCARD = "oso-fedora-clean_*"
DEVENV_BASE_WILDCARD = "oso-fedora-base_*"
DEVENV_STAGE_CLEAN_WILDCARD = "oso-fedora-stage-clean_*"
DEVENV_STAGE_BASE_WILDCARD = "oso-fedora-stage-base_*"

FORK_AMI_WILDCARD = "fork_ami_*"
DEVENV_AMI_WILDCARDS = {DEVENV_WILDCARD => {:keep => 1, :regex => /(oso-fedora)_(\d+)/}, 
                        DEVENV_STAGE_WILDCARD => {:keep => 8, :regex => /(oso-fedora-stage)_(\d+)/},
                        DEVENV_CLEAN_WILDCARD => {:keep => 1, :regex => /(oso-fedora-clean)_(\d+)/},
                        DEVENV_STAGE_CLEAN_WILDCARD => {:keep => 1, :regex => /(oso-fedora-stage-clean)_(\d+)/},
                        DEVENV_BASE_WILDCARD => {:keep => 1, :regex => /(oso-fedora-base)_(\d+)/},
                        DEVENV_STAGE_BASE_WILDCARD => {:keep => 1, :regex => /(oso-fedora-stage-base)_(\d+)/},
                        FORK_AMI_WILDCARD => {:keep => 50, :keep_per_sub_group => 1, :regex => /(fork_ami_.*)_(\d+)/}}
VERIFIER_REGEXS = {/^(oso-fedora)_(\d+)$/ => {},
                   /^(oso-fedora_verifier)_(\d+)$/ => {}, 
                   /^(oso-fedora-stage)_(\d+)$/ => {}, 
                   /^(oso-fedora-stage_verifier)_(\d+)$/ => {},
                   /^(oso-fedora-base)_(\d+)$/ => {}, 
                   /^(oso-fedora-stage-base)_(\d+)$/ => {},
                   /^(libra_benchmark)_(\d+)$/ => {:max_run_time => (60*60*24)},
                   /^(broker_extended)_(\d+)$/ => {:max_run_time => (60*60*4)},
                   /^(runtime_extended)_(\d+)$/ => {:max_run_time => (60*60*4)},
                   /^(rhc_extended)_(\d+)$/ => {:max_run_time => (60*60*4)},
                   /^(test_pull_requests)_(\d+)$/ => {:multiple => true},
                   /^(test_pull_requests_stage)_(\d+)$/ => {:multiple => true},
                   /^(merge_pull_request)_(\d+)$/ => {},
                   /^(merge_pull_request_stage)_(\d+)$/ => {},
                   /(fork_ami)_.*_(\d+)$/ => {:multiple => true},
                   /^(broker_check)_(\d+)$/ => {}, 
                   /^(node_check)_(\d+)$/ => {}, 
                   /^(libra_coverage)_(\d+)$/ => {:max_run_time => (60*60*1)}}
TERMINATE_REGEX = /terminate|teminate|termiante|terminatr|terninate/
VERIFIED_TAG = "qe-ready"

# Specify the source location of the SSH key
# This will be used if the key is not found at the location specified by "RSA"
RSA = File.expand_path("~/.ssh/devenv.pem")
RSA_SOURCE = ""

SAUCE_USER = ""
SAUCE_SECRET = ""
SAUCE_OS = ""
SAUCE_BROWSER = ""
SAUCE_BROWSER_VERSION = ""
CAN_SSH_TIMEOUT=90

JENKINS_HOME_DIR = '/var/lib/openshift/826e5217a6a447b6bcc9ff6a477d324a/app-root/data'

SIBLING_REPOS = {'origin-server' => ['../origin-server-working', '../origin-server-fork', '../origin-server', JENKINS_HOME_DIR + '/jobs/origin-server/workspace'],
                 'rhc' => ['../rhc-working', '../rhc-fork', '../rhc', JENKINS_HOME_DIR + '/jobs/rhc/workspace'],
                 'origin-dev-tools' => ['../origin-dev-tools']}
SIBLING_REPOS_GIT_URL = {'origin-server' => 'https://github.com/openshift/origin-server.git',
                        'rhc' => 'https://github.com/openshift/rhc.git',
                        'origin-dev-tools' => 'https://github.com/openshift/origin-dev-tools.git'}

CUCUMBER_OPTIONS = '--strict -f progress -f junit --out /tmp/rhc/cucumber_results -t ~@not-origin'

redhat_release = File.open("/etc/redhat-release").read
ignore_packages = ['openshift-origin-node-util', 'rubygem-openshift-origin-auth-kerberos', 'rubygem-openshift-origin-console']
ignore_packages << "openshift-origin-cartridge-ruby-1.9-scl" if redhat_release.match(/Fedora/)
ignore_packages << "openshift-origin-cartridge-jbosseap-6.0" if `yum search jboss-eap6 2> /dev/null`.match(/No Matches found/)
ignore_packages << "openshift-origin-cartridge-jbossas-7" if `yum search jboss-as7 2> /dev/null`.match(/No Matches found/)
ignore_packages << "openshift-origin-cartridge-jenkins-1.4" if `yum search jenkins-plugin-openshift 2> /dev/null`.match(/No Matches found/)
ignore_packages << "openshift-origin-cartridge-nodejs-0.6" if `yum search nodejs-supervisor 2> /dev/null`.match(/No Matches found/)

IGNORE_PACKAGES = ignore_packages
$amz_options = {:key_name => KEY_PAIR, :instance_type => TYPE}
