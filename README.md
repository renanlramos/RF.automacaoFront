<h2>1.Python 3.13.5</h2>
<p>Robot Framework: pip install robotframework</p>
<p>SeleniumLibrary: pip install --upgrade robotframework-seleniumlibrary</p>
<p>Robotmetrics: pip install robotframework-metrics==3.7.0</p>

<h2>2.Como executar os testes localmente:</h2>
<p>Navegue até a pasta principal do projeto e abra o terminal</p>
<h3>Executar todas as suite de testes:</h3>
<p>(Windows🪟) robot --outputdir .\results\ .\tests</p>
<p>(Linux 🐧) robot --outputdir results/ tests/</p>

<h2>3.Docker⚓:</h2>
<p>Navegue até a pasta principal do projeto, abra o terminal e digite:</p>
<p>docker build -t robot-python .  ->Constroi a imagem<br>
docker run -it robot-python ->Roda a imagem<br>
<H3>ATENÇÃO:</H3>
<p>Para executar o container e ter o compartilhamento pelo host dos arquivos de teste em TEMPO REAL deve comentar os seguintes comandos do dockerfile:<br>
-----------------------------------------------------------------------<br>
- COPY . /usr/src/app <br>
- ENTRYPOINT ["robot"] <br>
- CMD ["--outputdir", "results/", "tests/"]<br>
-----------------------------------------------------------------------</p>
<p>Então digite o seguinte comando para acessar o bash já no local de compartilhamento do container:<br>
docker run -it --rm -v "C:\Users\5by5\Documents\Robot\RF.automacaoFront":/usr/src/app ^<br>
--entrypoint /bin/bash ^ <br>
robot-python</p>
<p>Para executar os testes, digite:<br>
robot --outputdir results/ tests/</p>

