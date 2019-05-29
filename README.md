# Navinha
Speedrun de shmup!

## Inimigos
- Default
  - Nave inimiga básica, pouca vida e velocidade padrão, apenas atira e dá dano ao toque;
- Default x2
  - Igual a Default mas com um buff no dano;
- Kamikaze
  - Nave com velocidade aprimorada, não atira, porém corre em direção ao player e explode;
  - Se for morta há uma distância curta, ainda assim causa dano ao player;
- Blob Cell
  - Nave grande que se movimenta e atira da mesma forma da Default;
  - Quando morta, gera 2 filhas menores e de mesmo comportamento;
  - As filhas quando morrem também geram 2 filhas;
  - 3 niveis, Blob original -> filha_1 -> filha_2;
  
                 

## Como os inimigos irão escalar em dificuldade a cada wave

| INIMIGOS        | WAVE 1  _Power_  | WAVE 1  _Speed_   | WAVE 2  _Power_  | WAVE 2  _Speed_   | WAVE 3  _Power_  | WAVE 3  _Speed_   | WAVE 4  _Power_  | WAVE 4  _Speed_   
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
|Default       | 1  | 1  | 1  | 1  | X  | X  | X  | X  |
|Default x2    | X  | X  | 1  | 1  | 1  | 1.2  | 1  | 1.4  |
|Kamikaze      | X  | X  | X  | X  | 1  | 1  | 1  | 1.5  |
|Blob Cell     | X  | X  | X  | X  | X  | X  | 1  | 1  |

Wave 5 seria o boss ;D


## Buffs
- Fire Rate
  - Aumenta a velocidade dos tiros
- Speed
  - Velocidade da nave
- Power
  - Aumenta o dano dos tios
- Spread
  - número de balas que saem a cada tiro
- Shield
  - 'Corações' bônus à sua vida original
  

Dentro das waves estarão espalhados os seguintes buffs 

| BUFFS        | Level 1  | Level 2   | Level 3  |
| ------------ | ------------ | ------------ | ------------ |
|Fire Rate   | 1.3  | 1.6  | X  |
|Speed       | 1.3  | 1.6  | X  |
|Power       | 1.3  | 1.6  | X  |
|Spread      | 3x  | 5x  | X  |
|Shield      | +1  | +2  | +3  |



Buffs de Speed e Power e Fire Rate só podem acumular 3x, por exemplo
- speed level 1 + power level 1 + fire rate level 1
- speed level 1 + speed level 1 + speed level 1

Se o jogador pegar mais um buff, ele irá substituir o primeiro que ele encontrou

Shield e Spread não acumulam, e são independentes dos outros buffs
