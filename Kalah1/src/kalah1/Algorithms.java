
package kalah1;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ListIterator;

public class Algorithms {

    /**
     *
     * @author meghana
     */
    /* Get next best move based on Alpha Beta technique
     * And traverse log shows the exploration of game
     * tree in order to select best next move.
     */
    public static class AlphaBeta {

        Helper helper = new Helper();
        private final int depth;
        private static int count = 0;

        public AlphaBeta(int depth) {
            super();
            this.depth = depth;
        }

        //Game tree exploration
        public KalahBoard alphabeta(KalahBoard g, int eval) throws IOException {
            KalahBoard nextstate = null;
            try {
                KalahBoard.Node root = new KalahBoard.Node("root", g, Double.NEGATIVE_INFINITY, Double.NEGATIVE_INFINITY, Double.POSITIVE_INFINITY, 0, true, null);
                getAllMoves_AB(root, eval);
                nextstate = helper.nextState(root);
            } catch (Exception ex) {
                System.out.println("Exception in AlphaBeta : " + ex.getMessage());
            }
            return nextstate;
        }

        /* Get all the valid moves based on current state
         * and select next best move
         */
        public void getAllMoves_AB(KalahBoard.Node n, int eval) throws IOException {
            count = n.depth;
            //Leaf Node
            if (count >= depth && !n.game.getGetAnotherTurn()) {
                if (eval == 1) {
                    n.eval = helper.eval1(n.game);
                } else if (eval == 2) {
                    n.eval = helper.eval2(n.game);
                } else {
                    n.eval = helper.eval(n.game.getPlayer(), n.game.getPlayer1_Kalah(), n.game.getPlayer2_Kalah());
                }
                return;
            }
            boolean valid = false;
            if (count == depth && n.game.getGetAnotherTurn()) {
                valid = true;
            }
            while ((count < depth || valid) && !helper.GameOver(n.game)) {
                helper.expansion(n);
                valid = false;
                ListIterator<KalahBoard.Node> listIterator = n.children.listIterator();
                while (listIterator.hasNext()) {
                    KalahBoard.Node temp = listIterator.next();
                    temp.alpha = n.alpha;
                    temp.beta = n.beta;
                    getAllMoves_AB(temp, eval);
                    if (n.max) {
                        if (temp.eval > n.eval) {
                            n.eval = temp.eval;
                        }
                        if (!prun(n)) {
                            if (temp.eval > n.alpha) {
                                n.alpha = temp.eval;
                            }
                        }
                    } else {
                        if (temp.eval < n.eval) {
                            n.eval = temp.eval;
                        }
                        if (!prun(n)) {
                            if (temp.eval < n.beta) {
                                n.beta = temp.eval;
                            }
                        }
                    }
                    if (prun(n)) {
                        break;
                    }
                }
                count++;
            }
        }

        //Check pruning condition
        public boolean prun(KalahBoard.Node n) {
            if (n.max) {
                if (n.beta <= n.eval) {
                    //Pruning
                    return true;
                } else {
                    return false;
                }
            } else {
                if (n.alpha >= n.eval) {
                    //Pruning
                    return true;
                } else {
                    return false;
                }
            }
        }
    }

    /* Get next best move based on Minimax technique
     * And traverse log shows the exploration of game
     * tree in order to select best next move.
     */
    public static class Minimax {

        Helper helper = new Helper();
        private final int depth;
        private static int count = 0;

        public Minimax(int depth) {
            super();
            this.depth = depth;
        }

        //Game tree exploration
        public KalahBoard minimax(KalahBoard g, int eval) {
            KalahBoard nextstate = null;
            try {
                KalahBoard.Node root = new KalahBoard.Node("root", g, Double.NEGATIVE_INFINITY, 0, true, null);
                getAllMovesMin(root, eval);
                nextstate = helper.nextState(root);
            } catch (Exception ex) {
                System.out.println("Exception in Minimax : " + ex);
                ex.printStackTrace();
            }
            return nextstate;
        }

        /* Get all the valid moves based on current state
         * and select next best move
         */
        public void getAllMovesMin(KalahBoard.Node n,int eval) throws IOException {
            count = n.depth;
            if (count >= depth && !n.game.getGetAnotherTurn()) {
                if (eval == 1) {
                    n.eval = helper.eval1(n.game);
                } else if (eval == 2) {
                    n.eval = helper.eval2(n.game);
                } else {
                    n.eval = helper.eval(n.game.getPlayer(), n.game.getPlayer1_Kalah(), n.game.getPlayer2_Kalah());
                }
                return;
            }
            boolean valid = false;
            if (count == depth && n.game.getGetAnotherTurn()) {
                valid = true;
            }
            while ((count < depth || valid) && !helper.GameOver(n.game)) {
                helper.expansion(n);
                valid = false;
                ListIterator<KalahBoard.Node> listIterator = n.children.listIterator();
                while (listIterator.hasNext()) {
                    KalahBoard.Node temp = listIterator.next();
                    getAllMovesMin(temp, eval);
                    if (n.max) {
                        if (n.eval < temp.eval) {
                            n.eval = temp.eval;
                        }
                    } else {
                        if (n.eval > temp.eval) {
                            n.eval = temp.eval;
                        }
                    }
                }
                count++;
            }
        }
    }
    
}
