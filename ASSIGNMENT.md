Link naar de presentatie: [HIER](https://docs.google.com/presentation/d/18ryBpP-beQaL1szCQQoTea4AAFlT7mrduwAP-xFhdNU/edit?usp=sharing)

# OPDRACHTEN:

1. Zorg ervoor dat je met de ping module allebei de nodes kan pingen, doe dit middels een ad-hoc commando.

2. Maak gebruik van het ansible project. Eén webserver is al voorgeïnstalleerd (paarse pagina). Zorg ervoor dat een tweede webserver op een andere host wordt geïnstalleerd (blauwe pagina). 

3. Maak van de overige node een loadbalancer. Dit doe je natuurlijk middels Ansible. Zorg ervoor dat de loadbalancer verbindingen opzet naar de 2 webservers.

4. Als je de opdracht goed hebt uitgevoerd, zie je de ene keer een blauwe en de andere keer een rode pagina.

- Git is nodig om gebruik te maken van AWX. Er zijn 2 opties:
- Maak gebruik van github of een eigen git instantie.
- Je maakt gebruik van de aangeleverde Gitea instantie. (vagrant up gitea)

5. Voer opdrachten 2 en 3 uit middels AWX.
- Upload de Ansible projecten in Git
- Zet de inventory in  AWX
- Voeg het project wat je hebt geupload in git toe aan AWX
- Maak een template aan en voer deze uit

