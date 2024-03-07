# Game Design Document

## Ogólne informacje

### Audtorzy

- Kamil Ciągło
- Mateusz Balicki

### Tytuł

Augmented Unit

### Gatunki

Gra będzie pomieszaniem gatunków gier narracyjnych i metroidvanii.
Gra narracyjna, bo silny nacisk będzie kładzony na fabułę i _environmental storytelling_, a z gatunku metroidvanii zapożyczona zostanie struktura poziomów i sposób postępu w grze.

### Odbiorcy

Docelową grupą odbiorców gry będą ludzie zaznajomieni z grami, w wieku około 16 do 30 lat, lub ludzie zainteresowani historiami opowiedzianymi nie wprost, z nutką niepokoju.

### Plaforma i wwymagania sprzętowe

<!-- Wymagania pożyczone od gry dead cells - podobnej graficznie i konceptualnie do naszej gry -->

"If your PC can run Windows, it can probably run this game", but let's give you some requirements

Aspekt | MINIMUM: | RECOMMENDED:
---|---|---
OS * | Windows 7+ | Windows 7+
Processor | Intel i5+ | Intel i5+
Memory | 2 GB RAM | 4 GB RAM
Graphics | Nvidia 450 GTS / Radeon HD 5750 or better | Nvidia GTX 460 / Radeon HD 7800 or better
Storage | 500 MB available space | 500 MB available space
Additional Notes | DirectX 9.1+ or OpenGL 3.2+ | DirectX 9.1+ or OpenGL 3.2+

### Monetyzacja

Gra zostanie wypuszczona w modelu free-to-play, aby zachęcić graczy do zagrania w nią i aby zdobyć odrobinę rozgłosu na rynku. Później mogą zostać wydane płatne dodatki do gry, które rozwiną grę o opcjonalne poziomy i poszerzą historię świata.

## Tematyka i osadzenie gry

### Lokacje

Gra rozgrywać się będzie na pokładzie wojskowego statku transportowego, którego załoga została wybita, a sam statek dryfuje uszkodzony na środku oceanu.
Z uwagi na gatunek gry (metroidvania) cały statek będzie jedną, dużą mapą, ale jego konkretne sekcje będą reprezentować oddzielne poziomy.

Przykładowe sekcje, które mogą się znaleźć w grze:
Nazwa | Obowiązkowy | Modyfikacja | Logi | Opis
---|---|---|---|---
Pokład statku | Y | dash | - | przeszkody w postaci pseudo-losowych uderzeń piorunów czy powiewów wiatru
Kajuty załogi | Y | double-jump | DUŻO, vague historia i tajne pokoje | skrót do innych rejonów, ale jest w nim dużo trupów, które w końcowym etapie gry uniemożliwią przejście przez ten sektor
Magazyn | Y | krzyk | minimum, basic story info | początkowa sekcja, w niej znajdziemy przejścia do dodatkowych poziomów i kilka podstawowych informacji, oraz drogi blokowane przez działka automatyczne
Reaktor | N | - | - | ukryty koło ostatniej sekcji, pozwala wyłączyć zasilanie - działkom blokującym inne opcjonalne pokoje i łodzi podwodnej
Serwerownia | Y | DEM (Deus Ex Machina) | DUŻO, silniejsze hinty na dodatkowe pokoje i głębszą fabułę | pokój z logami bezpieczeństwa, które mogą nakierować gracza na prawdziwe zakończenie gry, końcowa część gry, cutscenki here
Zbrojownia | N | - | trochę, żeby zrozumieć skąd broń nuklearna i co robił statek | w nim, z użyciem kodów z serwerowni, można aktywować bombę nuklearną, która rozpocznie odliczanie do samozniszczenia
Pokój z łodzią podwodną | N | - | minimum, mówiące po co łódź i że może przetrwać wybuch nuklearny | dzięki niemu można uciec ze statku po tym, jak uruchomimy bombę, łódź potrzebuje zasilania i kodu bezpieczeństwa
Pokój treningowy | Y | Narrator | Jeden, przykład mechaniki | Pokój, do którego jesteśmy teleportowaniu w ramach samouczka, będzie początkowo pokojem developerskim, w którym później umieścimy samouczek


### Fabuła

#### Wprowadzenie

Gracz jest robotem (AU - Augmented Unit), który aktywuje się (wychodząc z kapsuły) w szczelnie zamkniętym pomieszczeniu. Dowiaduje się tutaj o swoim celu - zabezpieczeniu tajnych danych znajdujących się na statku.
Po diagnozie systemów (tutorial) AU dostaje moduł odczytywania logów (narratora), a wyjście się otwiera i AU zostaje wypuszczony na statek, aby wypełnić swój cel.

#### Wątki

- Wątek główny
    - Głównym celem AU jest odnalezienie źródła problemów na statku, które znajduje się w __Serwerowni__, na specjalnym dysku zabezpieczonym szkłem?, które może zostać zniszczone jedynie z użyciem konkretnej __modyfikacji (augment)__. Dostanie się do niej nie jest możliwe od samego początku, więc AU musi znaleźć inne modyfikacje, które umożliwią przedostanie się do __Serwerowni__ przy okazji poznając historię statku i załogi. Ostatnia modyfikacja jest jednak silnie zabezpieczona i podniesienie jej aktywuje specjalny program obronny, który ma na celu zniszczyć wszystko, co znajduje się na statku i jest poza specjalnym pokojem (początkowym).
- Wątek poboczny - członkowie załogi
    - Niektórzy członkowie załogi (ciała znajdowane na statku) będą miały przy sobie __logi__, które pozwolą na zrozumienie dodatkowej fabuły, świata, czy mechanik.
- Wątek poboczny - inne roboty
    - Na statku będą się też znajdować inne roboty (sprawne lub nie), które pozwolą zrozumieć cel istnienia AU (gracza) w tym świecie.
- Wątek poboczny (opcjonalny) - zaburzenia czasu
    - Gra będzie się opierać o time-loop, który potencjalnie będzie można przerwać, wchodząc w interakcję z dodatkową zawartością. Przerwanie pętli będzie "__prawdziwym zakończeniem__", ale będzie wymagać od gracza wysadzenia statku w powietrze z użyciem broni nuklearnej, oraz ucieczkę.

### Postaci

#### Gracz

Augmented Unit — uniwersalny robot odpowiedzialny za przechowywanie sekretów statku w sytuacjach kryzysowych i odzyskiwanie danych. Może się modyfikować, aby ułatwić wykonanie swojego celu.

#### Przeciwnicy

- Działka automatyczne na statku blokujące dostęp do niektórych rejonów, wymagają zasilania, aby działać.
- Załoga statku (po cofnięciu się w czasie), ludzie, którzy próbują powstrzymać AU przed ucieczką ze statku(?), stoją w miejscu i strzelają.

#### NPC

Popsuty robot na starcie, mówiący o tym, że dane są w sytuacjach awaryjnych za specjalnym materiałem, który można zniszczyć tylko, używając DEM, czyli specjalnej broni. Posiada niski poziom inteligencji, który pozwala mu jedynie chodzić bez celu do momentu opowiedzenia historyjki.

## Rozgrywka i mechaniki

### Cel gry (cele/wyzwania/questy)

- __Głównym celem__ gracza będzie dostanie się do wspomnianej wcześniej __Serwerowni__. Po drodze napotka różne przeszkody w postaci poruszających się platform, systemów bezpieczeństwa na statku, czy zagrożeń środowiskowych (woda/ogień/prąd).
-  __Dodatkowo__ ciała członków załogi, czy roboty na statku będą mogły oferować informacje, na podstawie których gracz będzie mógł próbować dostać się do opcjonalnych, ukrytych obszarów, które pozwolą mu na odkrycie głębszej historii, czy ukrytych zakończeń.
- Przy __zebraniu ostatniej modyfikacji__ pojawi się pierwszy quest w grze - _"przeżyj"_ i gracz będzie musiał wrócić do początkowego pokoju w określonym czasie, przy okazji unikając zabezpieczeń, które zostaną aktywowane.

### Interakcja/kontrolery (/sterowanie?)

Postać gracza będzie kontrolowana za pomocą klawiatury (i myszy?) lub (opcjonalnie, nie w MVP) kontrolera.
Podstawowe sterowanie zostało przedstawione poniżej:

- __WSAD__ - poruszanie się
- __Space__ - skok (opcjonalnie, obok W) [double-jump - modyfikacja]
- __LShift__ - dash (modyfikacja)
- __E__ - interakcja
- __LPM__ - DEM (ostatnia modyfikacja, atak mieczem)
- __Q__ - krzyk (modyfikacja)

### Multiplayer

Z uwagi na gatunek gry (narracyjna), nie będzie ona wspierała gry wieloosobowej. Jedyną namiastką mogą być globalne/lokalne tablice wyników do speedrunów

## Przebieg gry (flow)

### Mockup splashscreenów

![initial splash screen with animation-transition to Menu](images/image-1.png)

### cutscenki, narracja in-game'owa

- Cutscenki — nieliczne, w kluczowych momentach fabuły, renderowane w silniku, zabierając chwilowo kontrolę graczowi, lub opcjonalnie animowane (przy zakończeniach)
- Narracja — narrator odczytujący logi znajdowane na statku

### menu, hud, mapa, eq itp

Menu będzie animowanym przybliżeniem splashscreena z opcjami wyświetlanymi na monitorze (in-game hud)

![alt text](images/image-2.png)

### mapy

TODO - Lokacje są już wyżej w sekcji "Osadzenie gry", chodzi o Animacje przejść między poziomami?

![alt text](images/image-3.png)

## Zakres projektu

### harmonogram i podział prac

Przy każdym zadaniu znajdzie się jedna z trzech liter, która oznacza, przez kogo zostało ono wykonane:
- B — both, oboje
- K — Kamil
- M — Mateusz

Zadania będą przypisane konkretnym tygodniom i uzupełniane na bieżąco w poniższej liście

- __Tydzień 1 (29.02.2024 - 07.03.2024)__
    - __(B)__ Przygotowanie wstępnej wersji GDD i ogólnej wizji gry
    - __(B)__ Przygotowanie concept-artów
    - __(K)__ Przygotowanie ogólnego zarysu fabuły
    - __(M)__ Research podobnych historii i inspiracji do napisania szczegółowej fabuły
    - __(K)__ Wstępne napisanie kilku logów
- __Tydzień 2 (07.03.2024 - 14.03.2024)__
- __Tydzień 3 (14.03.2024 - 21.03.2024)__
- ...

## Assety

### concept-art, modele, skrypty, tekstury, animacje

TODO

### dźwięki, muzyka, narracje, dialogi

TOOD

## PoC/prototyp

Mamy zrobić grę działającą przed "First Playable"? Jak to ma wyglądać?
