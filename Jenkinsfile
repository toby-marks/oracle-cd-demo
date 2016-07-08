def buildIn(env) {
    
    node('docker') {
    
        git 'https://github.com/toby-marks/oracle-cd-demo.git'
        docker.image(env).inside {
            sh 'su oracle'
            sh 'cd $ORACLE_HOME'
            sh 'bin/sqlplus / as sysdba @$env.WORKSPACE/app/exec_all.sql'
            sh 'cat exec_all.[0-9]'
        }
    }
}

parallel '11g': {

    stage 'Build and deploy app on 11g'

    stage 'Run tests'
    
}, '12c': {

    stage 'Build and deploy app on 12c'
    buildIn('sath89/oracle-12c')

    stage 'Run tests'

}

node {

    stage 'Request final approval for production deployment', concurrency: 1
    input 'Ready to promote?'
    
    stage 'Deploy to prod'    

}