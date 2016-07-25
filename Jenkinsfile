stage 'Build and deploy'

parallel oracle11g: {
 
        node {
            echo 'Build and deploy app on 11g'
        }

}, oracle12c: {

        node {
            echo 'Build and deploy app on 12c container'
            docker.image('sath89/oracle-12c').inside('-u 0:0 -e WEB_CONSOLE=false -p 1521 -v /u01/app/oracle') {

                echo 'Checking out project toby-marks/oracle-cd-demo from Github'
                git credentialsId: 'fcccf299-4944-494f-8755-d30f2e185922', url: 'http://github.com/toby-marks/oracle-cd-demo'
            
                sh 'pwd; ls -l'
                sh 'su oracle -c "$ORACLE_HOME/bin/sqlplus / as sysdba @instance"'
            }
        }
}

stage 'Run tests'

stage 'Deploy to production'
node {

    input 'Ready to promote?'
    
    echo 'Deploy to prod'    

}
