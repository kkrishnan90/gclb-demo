# gclb-demo
A demo showcasing the Google global load balancing capabilities.

## To run the demo follow the steps (Ensure to have proper APIs enabled - specifically Compute Engine API)
1. Clone the repository to Cloud Shell (ensure Google Cloud SDK is already installed)
2. Provide proper permissions to the bash files (<code>chmod +x filename.sh</code>) to both the bash file
3. Run <code>./demo-run.sh</code>
4. The demo creates two managed instance group across <code>us-central1</code> and <code>asia-southeast1</code> regions and adds them as a backend to the global <code>http</code> load balancer
5. Wait for the execution to complete
6. Copy the load balancer IP created on GCP console
7. If necessary to test Global Load Balancing capabilities, spin up a Windows VM in <code>us region</code> and use local browser
8. Use the Windows VM and copy the load balancer IP to the browser. As per the global load balancing logic, US instance application will be shown
9. Since I'm in Asia, if tried locally (the nearest asia-southeast1) the Asia application is shown

Reference Code for frontend <code>html</code> file <url>https://gist.githubusercontent.com/kkrishnan90/fd19913589cf2e6ca91b8ce5059226ca/raw/43263e747ed3433c116adc903e4056994f4de8dc/index.php</url>


