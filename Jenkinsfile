def buildIn(env) {
    
    node {
    
        echo 'Checking out project toby-marks/oracle-cd-demo from Github'
        git 'https://github.com/toby-marks/oracle-cd-demo.git'

        echo 'Spawning Docker database container to deploy app'
        docker.image(env).inside {
            sh 'su oracle'
            sh 'cd $ORACLE_HOME'
            sh 'bin/sqlplus / as sysdba @$env.WORKSPACE/app/exec_all.sql'
            sh 'cat exec_all.[0-9]'
        }
    }
}

stage 'Build and deploy'

parallel oracle11g: {
 
        node {
            echo 'Build and deploy app on 11g'
        }

}, oracle12c: {

        node {
            echo 'What do you build on 12c?'
            buildIn('sath89/oracle-12c')
        }
}

stage 'Run tests'

stage 'Deploy to production'
node {

    input 'Ready to promote?'
    
    echo 'Deploy to prod'    

}
