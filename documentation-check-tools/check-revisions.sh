#!/bin/bash
#
# Check all EAP books in a release have the same revision number
# 
# Nikoleta Ziakova nziakova@redhat.com
#

if [ $# -ne 5 ]; then
  echo "Five arguments are expected, usage: $0 EAP_RELEASE REVISION RELEASE_NOTES_REVISION_NUMBER OPENSHIFT_REVISION_NUMBER MIGRATION_TOOL_NUMBER OTHER_GUIDES_REVISION_NUMBER"
  echo "    EAP_RELEASE                     The minor EAP release, e.g. 70, 71, CD12, CD13, CD14, 72..."
  echo "    RELEASE_NOTES_REVISION_NUMBER   The expected revision number of Release Notes, e.g. a4d45348a4d2787b53d1251f2e68ef2ce0de454a"
  echo "    OPENSHIFT_REVISION_NUMBER       The expected revision number of OpenShift docs, e.g. ec55a9b3f73b84ec38d42e475c3900382a6ca272"
  echo "    MIGRATION_TOOL_REVISION_NUMBER  The expected revision number of Migration Tool docs, e.g. 65e9180858d25d9dee90a0b852f6ed0f447006dc"
  echo "    OTHER_GUIDES_REVISION_NUMBER    The expected revision number of other guides, e.g. 6bff93b8742f6d230c071fd8541a51905e12d918"
  exit 1
fi

EAP_RELEASE=$1
RELEASE_NOTES_REVISION_NUMBER=$2
OPENSHIFT_REVISION_NUMBER=$3
MIGRATION_TOOL_REVISION_NUMBER=$4
OTHER_GUIDES_REVISION_NUMBER=$5


if [ "${EAP_RELEASE}" == "71" ]; then
    # List of EAP 7.1 books URLs
    declare -a RELEASE_NOTES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/7.1.0_release_notes"
    )

    declare -a OPENSHIFT_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/getting_started_with_jboss_eap_for_openshift_container_platform"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/getting_started_with_jboss_eap_for_openshift_online"
    )

    declare -a MIGRATION_TOOL_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/using_the_jboss_server_migration_tool"
    )

    declare -a OTHER_GUIDES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/introduction_to_jboss_eap"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/installation_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/getting_started_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/patching_and_upgrading_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/migration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/configuration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/management_cli_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/development_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/developing_ejb_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/developing_web_services_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/configuring_messaging"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/deploying_red_hat_jboss_enterprise_application_platform_on_amazon_ec2"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/using_jboss_eap_in_microsoft_azure"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/how_to_configure_server_security"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/how_to_configure_identity_management"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/how_to_set_up_sso_with_saml_v2"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/how_to_set_up_sso_with_kerberos"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/login_module_reference"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/security_architecture"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/performance_tuning_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/developing_hibernate_applications"
    )
fi

if [ "${EAP_RELEASE}" == "72" ]; then
    # List of EAP 7.2 books URLs
    declare -a RELEASE_NOTES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/7.2.0_release_notes"
    )

    declare -a OPENSHIFT_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/getting_started_with_jboss_eap_for_openshift_container_platform"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/getting_started_with_jboss_eap_for_openshift_online"
    )

    declare -a MIGRATION_TOOL_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/using_the_jboss_server_migration_tool"
    )

    declare -a OTHER_GUIDES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/introduction_to_jboss_eap"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/installation_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/getting_started_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/patching_and_upgrading_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/migration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/configuration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/management_cli_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/development_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/developing_ejb_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/developing_web_services_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/configuring_messaging"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/using_jboss_eap_in_microsoft_azure"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/how_to_configure_server_security"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/how_to_configure_identity_management"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/how_to_set_up_sso_with_saml_v2"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/how_to_set_up_sso_with_kerberos"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/login_module_reference"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/security_architecture"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/performance_tuning_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/developing_hibernate_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/deploying_jboss_eap_on_amazon_web_services"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html-single/managing_transactions_on_jboss_eap"
    )
fi

if [ "${EAP_RELEASE}" == "CD16" ]; then
    # List of EAP 7.2 CD16 books URLs
    declare -a RELEASE_NOTES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/html-single/jboss_eap_continuous_delivery_16_release_notes"
    )

    declare -a OPENSHIFT_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/html-single/getting_started_with_jboss_eap_for_openshift_container_platform"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/html-single/getting_started_with_jboss_eap_for_openshift_online"
    )

    declare -a MIGRATION_TOOL_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/html-single/using_the_jboss_server_migration_tool"
    )

    declare -a OTHER_GUIDES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/introduction_to_jboss_eap"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/installation_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/getting_started_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/patching_and_upgrading_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/migration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/configuration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/management_cli_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/development_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/developing_ejb_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/developing_web_services_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/configuring_messaging"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/deploying_jboss_eap_on_amazon_web_services"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/using_jboss_eap_in_microsoft_azure"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/how_to_configure_server_security"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/how_to_configure_identity_management"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/how_to_set_up_sso_with_saml_v2"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/how_to_set_up_sso_with_kerberos"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/login_module_reference"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/security_architecture"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/performance_tuning_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/developing_hibernate_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/16/single/managing_transactions_on_jboss_eap"
    )
fi

if [ "${EAP_RELEASE}" == "CD17" ]; then
    # List of EAP 7.3 CD17 books URLs
    declare -a RELEASE_NOTES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/jboss_eap_continuous_delivery_17_release_notes"
    )

    declare -a OPENSHIFT_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/getting_started_with_jboss_eap_for_openshift_container_platform"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/getting_started_with_jboss_eap_for_openshift_online"
    )

    declare -a MIGRATION_TOOL_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/using_the_jboss_server_migration_tool"
    )

    declare -a OTHER_GUIDES_URLS=(
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/introduction_to_jboss_eap"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/installation_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/getting_started_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/patching_and_upgrading_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/migration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/configuration_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/management_cli_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/development_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/developing_ejb_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/developing_web_services_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/configuring_messaging"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/deploying_jboss_eap_on_amazon_web_services"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/using_jboss_eap_in_microsoft_azure"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/how_to_configure_server_security"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/how_to_configure_identity_management"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/how_to_set_up_sso_with_saml_v2"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/how_to_set_up_sso_with_kerberos"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/login_module_reference"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/security_architecture"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/single/performance_tuning_guide"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/developing_hibernate_applications"
      "https://doc-stage.usersys.redhat.com/documentation/en-us/jboss_enterprise_application_platform_continuous_delivery/17/html-single/managing_transactions_on_jboss_eap"
    )
fi

REVISIONS=""
INCORRECT_REVISIONS=""
RET=0
rm -rf books
mkdir books

check_revisions() {

    REVISION_NUMBER="$1"
    shift
    URL_LIST=("$@")

    if [ "${REVISION_NUMBER}" == "0" ]; then
        echo "\n=== Skipping this set of docs...\n"
        return
    fi

    for URL in "${URL_LIST[@]}"; do

      FILENAME=`echo ${URL} | sed "s/.*\/\(.*\)/\1/g"`
      FILE="books/${FILENAME}"

      echo -e "\n=== Book name: ${FILENAME}"
      echo -e "=== URL: ${URL}\n"

      wget --no-check-certificate ${URL} -O ${FILE}
      REVISION=`cat ${FILE} | grep "<meta name=\"revision\"" | sed "s/.*revision=\"\(.*\)\" page.*/\1/g"`
      REVISIONS="${REVISIONS}\n${REVISION} ${FILENAME}"

      echo -e "\n=== Revision: ${REVISION}"

      if [[ ${REVISION} =~ ${REVISION_NUMBER}.* ]]; then
        echo "=== OK - Revision number is correct"
      else
        echo "=== FAIL - Revision number is incorrect"
        INCORRECT_REVISIONS="${INCORRECT_REVISIONS}\n${REVISION} ${FILENAME}"
        RET=1
      fi

    done
}

echo "\n=== Release Notes"
check_revisions ${RELEASE_NOTES_REVISION_NUMBER} "${RELEASE_NOTES_URLS[@]}"
echo "\n=== OpenShift docs"
check_revisions ${OPENSHIFT_REVISION_NUMBER} "${OPENSHIFT_URLS[@]}"
echo "\n=== Migration Tool docs"
check_revisions ${MIGRATION_TOOL_REVISION_NUMBER} "${MIGRATION_TOOL_URLS[@]}"
echo "\n=== Other guides"
check_revisions ${OTHER_GUIDES_REVISION_NUMBER} "${OTHER_GUIDES_URLS[@]}"

echo ""
echo "All revisions:"
echo -e ${REVISIONS}
echo ""
echo "Incorrect revisions:"
echo -e ${INCORRECT_REVISIONS}

exit ${RET}
