# Bloquer ai.exe - Microsoft Office Copilot

Ce script bloque le processus `ai.exe` utilisé par Microsoft Office Copilot, qui s'intègre dans Word, Outlook, Excel et PowerPoint.

**Pour l'utiliser :**
- Copiez le contenu du fichier `.bat`
- Collez-le dans le Bloc-notes
- Enregistrez sous : `bloquer_ai_office.bat`
- Clic droit → Exécuter en tant qu'administrateur

Le script est idempotent — vous pouvez le relancer sans risque, il ne crée pas de doublons.

---

## Ce que fait ai.exe concrètement

| Fonction | Description |
| -- | -- |
| **Analyse de contenu en temps réel** | Lecture du document pour suggestions contextuelles |
| **Recherche intelligente** | "Insights" ou "Idées" dans le ruban Office |
| **Correction/assistance** | Vérification avancée de grammaire, style, accessibilité |
| **Extraction de données** | Analyse de tableaux, dates, entités nommées |
| **Services cloud locaux** | Préparation/envoi de données vers les serveurs Microsoft |

## Le problème : blocage d'enregistrement dans Word

ai.exe s'accroche au processus parent (Word, Outlook) et verrouille le fichier en cours d'analyse. Quand le module IA plante, reste bloqué, ou entre en conflit :

- Word détecte un verrou sur le document
- L'enregistrement échoue avec une erreur "fichier utilisé par un autre processus"
- Word peut freezer ou afficher un dialogue d'erreur récurrent

C'est un bug connu de ces modules d'IA forcés via les mises à jour Office — particulièrement sur les versions 2016/2019.

## Avant / Après blocage

| Avant le blocage | Après le blocage |
| -- | -- |
| `ai.exe` analysait activement vos documents | Plus d'analyse en arrière-plan |
| Risque de blocage d'enregistrement | Enregistrement fluide |
| Potentiel envoi de métadonnées vers Microsoft | Données restent locales |
| Consommation RAM/CPU (~23 Mo + activité) | Ressources libérées |

Le blocage IFEO est doublement bénéfique : stabilité retrouvée + confidentialité améliorée. Microsoft n'a pas documenté ce comportement de verrouillage, mais il est bien réel sur les installations où le module IA déconne.

---

## Inverser le blocage

```cmd
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe" /f
```