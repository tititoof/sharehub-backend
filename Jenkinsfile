pipeline {
    agent {
        node {
            label 'agent_rails'
        }
    }
    environment { 
        RUBY_VERSION = 'ruby-3.2.2'
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                script {
                    sh("""
                        echo $SHELL
                        cat ~/.bashrc
                        ls ~/.rvm/scripts/rvm
                        . ~/.rvm/scripts/rvm &> /dev/null
                        rvm install $RUBY_VERSION
                        rvm use $RUBY_VERSION
                        ruby -v
                        gem -v
                        gem install bundler
                    """)
                }
            }
        }
        stage('Tests') {
            steps {
                echo 'Testing..'
                script {
                    withCredentials([string(credentialsId: 'sharehub-backend-credentials-ci-cd', variable: 'TEST_CREDENTIALS')]) {
                        sh """
                            export RAILS_ENV=test
                            . ~/.rvm/scripts/rvm &> /dev/null
                            rvm use $RUBY_VERSION
                            gem cleanup
                            gem update bundler
                            bundle install
                            echo "$TEST_CREDENTIALS" > config/credentials/ci-cd.key
                            gem install mailcatcher -v 0.9.0.beta2
                            gem install shoulda-matchers
                            mailcatcher
                            rm -Rf ./coverage
                            RAILS_ENV=ci-cd bundle exec rake db:create
                            RAILS_ENV=ci-cd bundle exec rake db:migrate
                            RAILS_ENV=ci-cd bundle exec rspec spec/
                            ruby -rjson -e 'sqube = JSON.load(File.read("coverage/.resultset.json"))["RSpec"]["coverage"].transform_values {|lines| lines["lines"]}; total = { "RSpec" => { "coverage" => sqube, "timestamp" => Time.now.to_i }}; puts JSON.dump(total)' > coverage/.resultset.solarqube.json
                        """
                        try {
                            sh """
                                . ~/.rvm/scripts/rvm &> /dev/null
                                rvm use $RUBY_VERSION
                                gem install rubocop
                                bundle exec rubocop app --format json --out out/rubocop-result.json
                            """
                        } catch (err) {
                            echo "Rubocop error "
                            echo err.getMessage()
                        }
                        echo 'Finished tests!'
                    }
                }
            }
        }
        stage('SonarQube Quality Gate') {
            steps {
                echo 'Check quality..'
                script {
                    def scannerHome = tool 'sonarqube-scanner';
                    def sonarqubeBranch = 'sharehub-backend-dev';
                    withCredentials([string(credentialsId: 'sonarqube-server', variable: 'SONAR_URL'),
                        string(credentialsId: 'sonarqubeId', variable: 'SONAR_CREDENTIALS')]) {
                        withSonarQubeEnv("sonarqube") {
                            if (env.BRANCH_NAME == 'main') {
                                sonarqubeBranch = 'sharehub-backend'
                            }
                            sh """${scannerHome}/bin/sonar-scanner \
                                    -Dsonar.projectKey=$sonarqubeBranch \
                                    -Dsonar.sources='app' \
                                    -Dsonar.exclusions=app/assets/**/* \
                                    -Dsonar.host.url=$SONAR_URL \
                                    -Dsonar.ruby.coverage.reportPaths=coverage/.resultset.solarqube.json \
                                    -Dsonar.ruby.rubocop.reportPaths=out/rubocop-result.json \
                                    -Dsonar.login=$SONAR_CREDENTIALS"""
                        }
                    }
                }
            }
        }
        stage("Quality Gate") {
            steps {
                script {
                    withSonarQubeEnv("sonarqube") {
                        sleep(20)
                        def qualitygate = waitForQualityGate()
                        if (qualitygate.status != "OK") {
                            env.WORKSPACE = pwd()
                            error "Pipeline aborted due to quality gate coverage failure: ${qualitygate.status}"
                        }
                    }
                }
            }
        }
        stage('Github update') {
            steps {
                script {
                    def giteaBranch = env.BRANCH_NAME;
                    if (env.BRANCH_NAME.startsWith('PR')) {
                        echo "PR branch"
                    } else {
                        if (env.BRANCH_NAME == 'main') {
                            withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_CREDENTIALS')]) {
                                sh '''
                                    if git remote | grep github > /dev/null; then
                                        git remote rm github
                                    fi
                                    git remote add github https://$GITHUB_CREDENTIALS@github.com/tititoof/sharehub-backend.git
                                '''
                                sh """
                                    git config --global user.email "chartmann.35@gmail.com"
                                    git config --global user.name "Christophe Hartmann"
                                    touch github-update.txt
                                    git rm ./Jenkinsfile
                                    git add .
                                    git commit -m "feat(github): update repository"
                                    git push -f github HEAD:main
                                """
                            }
                        }
                        if (env.BRANCH_NAME == 'develop') {
                            withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_CREDENTIALS')]) {
                                sh '''
                                    if git remote | grep github > /dev/null; then
                                        git remote rm github
                                    fi
                                    git remote add github https://$GITHUB_CREDENTIALS@github.com/tititoof/sharehub-backend.git
                                '''
                                sh """
                                    git config --global user.email "chartmann.35@gmail.com"
                                    git config --global user.name "Christophe Hartmann"
                                    touch github-update.txt
                                    git add .
                                    git commit -m "feat(github): update repository"
                                    git push -f github HEAD:develop
                                """
                            }
                        }
                        echo 'Github finished'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying finished'
            }
        }
    }
}