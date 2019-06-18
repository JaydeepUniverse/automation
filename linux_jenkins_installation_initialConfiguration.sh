#!/bin/bash

yum install java-1.8.0-openjdk-devel -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins -y

sed -i 's/JENKINS_JAVA_OPTIONS.*/JENKINS_JAVA_OPTIONS\=\"\-Djava\.awt\.headless\=true\ \-Djenkins\.install\.runSetupWizard\=false\"/' /etc/sysconfig/jenkins

mkdir -p /var/lib/jenkins/init.groovy.d

cat <<EOF1 > /var/lib/jenkins/init.groovy.d/security.groovy
#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule
import hudson.security.csrf.DefaultCrumbIssuer
import jenkins.model.Jenkins

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin")
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class)

def j = Jenkins.instance
if(j.getCrumbIssuer() == null) {
    j.setCrumbIssuer(new DefaultCrumbIssuer(true))
    j.save()
    println 'CSRF Protection configuration has changed.  Enabled CSRF Protection.'
}
else {
    println 'Nothing changed.  CSRF Protection already configured.'
}
EOF1

cat <<EOF2 > /var/lib/jenkins/init.groovy.d/installPlugins.groovy
#!groovy

import jenkins.model.*
import java.util.logging.Logger

def logger = Logger.getLogger("")
def installed = false
def initialized = false
def pluginParameter = "ws-cleanup timestamper credentials-binding build-timeout antisamy-markup-formatter cloudbees-folder pipeline-stage-view pipeline-github-lib github-branch-source workflow-aggregator gradle ant mailer email-ext ldap pam-auth matrix-auth ssh-slaves github git"

def plugins = pluginParameter.split()
logger.info("" + plugins)
def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()
plugins.each {
  logger.info("Checking " + it)
  if (!pm.getPlugin(it)) {
    logger.info("Looking UpdateCenter for " + it)
    if (!initialized) {
      uc.updateAllSites()
      initialized = true
    }
    def plugin = uc.getPlugin(it)
    if (plugin) {
      logger.info("Installing " + it)
        def installFuture = plugin.deploy()
      while(!installFuture.isDone()) {
        logger.info("Waiting for plugin install: " + it)
        sleep(3000)
      }
      installed = true
    }
  }
}
if (installed) {
  logger.info("Plugins installed, initializing a restart!")
  instance.save()
  instance.restart()
}
EOF2

chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d/
systemctl start jenkins
systemctl enable jenkins
