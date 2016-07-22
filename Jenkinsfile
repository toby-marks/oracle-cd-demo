stage 'Build and deploy'

parallel oracle11g: {
 
        node {
            echo 'Build and deploy app on 11g'
        }

}, oracle12c: {

        node {
            echo 'Build and deploy app on 12c container'
            docker.image('sath89/oracle-12c').inside('-u 0:0') {

                echo 'Checking out project toby-marks/oracle-cd-demo from Github'
            
                sh 'whoami; pwd; ls -l'
            }
        }
}

stage 'Run tests'

stage 'Deploy to production'
node {

    input 'Ready to promote?'
    
    echo 'Deploy to prod'    

}
