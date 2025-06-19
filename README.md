<h2>Python 3.13.5</h2>
<p>Robot Framework: pip install robotframework</p>
<p>SeleniumLibrary: pip install --upgrade robotframework-seleniumlibrary</p>
<p>Robotmetrics: pip install robotframework-metrics==3.7.0</p>

<h2>Como executar os testes localmente:</h2>
<p>Navegue até a pasta principal do projeto e abra o terminal</p>
<h3>Executar todas as suite de testes:</h3>
<p>(Windows🪟) robot --outputdir .\results\ .\tests</p>
<p>(Linux 🐧) robot --outputdir results/ tests/</p>

<h2>Docker⚓:</h2>
<p>Navegue até a pasta principal do projeto, abra o terminal e digite:</p>
<p>docker build -t robot-python .  ->Constroi a imagem</p>
<p>docker run -it --rm ^ <br>
<p>Abrir o bash já com compartilhamento do seus arquivos locais do teste (alterar para o caminho do seu projeto)</p>
-v "C:\Users\User\Documents\Robot\Test":/usr/src/app ^ <br>
--entrypoint /bin/bash ^ <br>
robot-python</p>

<p></p>
<p></p>