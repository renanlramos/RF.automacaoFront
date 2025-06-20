<h2>1.Python 3.13.5</h2>
<p>Robot Framework: pip install robotframework</p>
<p>SeleniumLibrary: pip install --upgrade robotframework-seleniumlibrary</p>
<p>Robotmetrics: pip install robotframework-metrics==3.7.0</p>
<p>DatabaseLibrary: pip install robotframework-databaselibrary<br>
*to connect this library to your database, you need to download your db module, for example pyMySQL</p>



        
<h2>2.To run tests localy:</h2>
<p>Go to project main folder, open terminal or CMD and type:</p>
<h3>To execute complete suit tests:</h3>
<p>(Windows🪟) robot --outputdir .\results\ .\tests</p>
<p>(Linux 🐧) robot --outputdir results/ tests/</p>

<h2>3.Docker⚓:</h2>
<p>Go to project main folder, open terminal or CMD and type:</p>
<p>docker build -t robot-python .  ->Build image<br>
docker run -it robot-python ->Runs image</p>
<H3>ATTENTION❗:</H3>
<p>To build the image while sharing files with host in real time you must remove the followings dockerfile commands:<br>
-----------------------------------------------------------------------<br>
- COPY . /usr/src/app <br>
- ENTRYPOINT ["robot"] <br>
- CMD ["--outputdir", "results/", "tests/"]<br>
-----------------------------------------------------------------------</p>
<p>This command inits bash on work directory sharing files with host path:<br>
docker run -it --rm -v "C:\Users\5by5\Documents\Robot\RF.automacaoFront":/usr/src/app ^<br>
--entrypoint /bin/bash ^ <br>
robot-python</p>
<p>To run tests:<br>
robot --outputdir results/ tests/</p>

