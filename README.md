# Tech test
## <u>DevSecOps exercise–supermarket checkout</u>

Written in the Java programming language, implement the code for a supermarket 
checkout that calculates the total price of a number of items.

In a normal supermarket, items for sale are identified using Stock Keeping Units,
or `SKUs`. In our store, we'll use individual letters of the alphabet 
(A, B, C, and so on) to represent these SKUs. Our goods are priced individually,
however, some items are multi-priced: buy **n** of them, and they'll cost you **y** instead.

For example, item `A` might cost `£0.50` individually, but this week we have
a special offer: buy three `A`s and they`ll cost you `£1.30`. 
In fact, this week`s prices are:

| Item | Unit Price |        Special Price |
|------|:----------:|---------------------:|
| A    |     50     |            3 for 130 |
| B    |     20     |             2 for 38 |
| C    |     5      | 3 for 50<sup>1</sup> | 


- This exercise will be used to gauge how you approach devsecops – the processes you use, the quality of your code and the robustness of your solution.
- **DO** use as many or as few AWS Services as you normally would when working to produce a production service
- You will require access to AWS, any required services can be configured using AWS Free Tier - https://aws.amazon.com/free/
- Once you have completed the outlined tasks below, please create a public Github account and publish a README detailing the steps you took to deploy the solution, and, if appropriate, any infrastructure-as-code (IaC) you used to configure the solution.
  - Feel free to write tests, use version control and rely on the third party libraries provided.
- **DON'T** get hung up on the specifics of the implementation
  - The problem is intentionally abstract, giving you the freedom to come up with your own unique solution.
  - This is an opportunity to demonstrate your way of working and your approach to creative problem-solving – there are no precise user requirements (aside from the specification above).


<hr/>
- (<sup>1</sup>. The price calculated for any quantity of an SKU with multiple special prices will be the cheapest combination of its special prices. For example: If you buy 5 ‘C’s you would get2   for 38 +   3 for 50. If   you buy 4   ‘C’s you would get3   for 50 + 1   for 20rather than 2   for 38 + 2   for 38.)


## Running the sample solution
- This application is built using maven and has had minimal changes to make it work spring boot 3

* Java 17 (amazon corretto distribution used locally)
* Maven (3.8.6 used in development)
* Spring boot 3.x.x

### Running the app locally 
mvn clean spring-boot:run and then go http://localhost:8080 to see the UI

### Running the tests
mvn clean test

## Exercise  
<hr/>

### Deploy the supermarket checkout java application in AWS
- Deploy the application using container or as a lambda securely in AWS using IaC
- Implement CDN caching for the application
- You have two days to come up with the solution, share the URL to the app and the github code
###SOLUTION:
1.Added below dependency to avoid httpclient error in the initial mvn clean spring:run
2. 		<dependency>
    	<groupId>org.apache.httpcomponents</groupId>
    	<artifactId>httpclient</artifactId>
    	<version>4.5.14</version>
</dependency>
3.Create jar file  tdd-supermarket-1.0.0.jar by mvn clean install
4.Run mvn clean spring:run and mvn clean test ,Application was up and reachable to http://localhost:8080/ ,Refer Tddsupermarket.PNG
5.Create Dockerfile 
6.Build image using docker desktop on local ,Image name:adeeba3480/tdd-supermarket:latest
7.Push local image to ECR ,After installing AWS CLI in local AWSCLIV2.msi from https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
###
C:\Users>aws configure
AWS Access Key ID [None]:
AWS Secret Access Key [None]: 
Default region name [None]: ap-south-1
Default output format [None]: json

C:\Users>aws ecr get-login-password --region ap-south-1| docker login --username AWS --password-stdin 058264341297.dkr.ecr.ap-south-1.amazonaws.com
Login Succeeded

C:\Users>docker tag adeeba3480/tdd-supermarket:latest 058264341297.dkr.ecr.ap-south-1.amazonaws.com/tddsupermarket

C:\Users>docker push 058264341297.dkr.ecr.ap-south-1.amazonaws.com/tddsupermarket
Using default tag: latest
The push refers to repository [058264341297.dkr.ecr.ap-south-1.amazonaws.com/tddsupermarket]
d0b9f5ab708a: Pushed
b6aec3236c10: Pushed
d9907b0445f9: Pushed
latest: digest: sha256:xxxxxx size: 954

C:\Users>
Login Succeeded
#####

8.Verify the image at https://ap-south-1.console.aws.amazon.com/ecr/private-registry/repositories?region=ap-south-1

9.Create ECS 
-Creat Task defination using  tddsupermarket-AWS-CLI.json
-Create CLuster using fargate instance and sg config 
- Scan the image and Copy the public ip of the ECS http://52.66.86.91:8080/ Refer output in Tddsupermarket.PNG
- Verified the container logs as well which has SPRING boot running info
   or
10 .I did create EC2 instance using terraform Iac script Terraform scripts.rtf
  -DId Manual installtion Using of docker using yum commands .
  -After pushing the image and docker run -p 8080:8080 adeeba3480/tdd-supermarket:latest started the application
  -Unfortunately IP of the EC2 instance wasnt reachable to get the output in browser ,I had created using ECR and ECS .
  -Later figured out security group wasnt properly configured the rules for inbound and outbound caused the issue .

 ** ####THANK YOU**
  
Note:
CDN caching is pending because I'm not sure on CDN and it had paid service [couldnt opt due to free account access].
