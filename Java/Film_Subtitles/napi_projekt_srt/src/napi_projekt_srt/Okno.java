package napi_projekt_srt;

import java.awt.TextArea;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

public class Okno extends javax.swing.JFrame {

    Pattern wzor = Pattern.compile("[0-9]{1,3}");
    Pattern wzor2 = Pattern.compile("[0-9]{3}");
    static String nazwa;
    static int sekund;
    static int set;
    static int kom;

    public Okno() {
        initComponents();
        kor_p.setSelected(true);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        sekundy = new javax.swing.JTextField();
        setne = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        importuj = new javax.swing.JButton();
        start = new javax.swing.JButton();
        koniec = new javax.swing.JLabel();
        sciezka_import = new javax.swing.JTextField();
        kompen = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        przyspiesz = new javax.swing.JRadioButton();
        zwolnij = new javax.swing.JRadioButton();
        jLabel7 = new javax.swing.JLabel();
        kor_p = new javax.swing.JRadioButton();
        kor_t = new javax.swing.JRadioButton();
        exit = new javax.swing.JButton();
        info = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Dopasuj napisy do filmu");
        setLocation(new java.awt.Point(500, 250));

        sekundy.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        sekundy.setText("0");
        sekundy.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                sekundyMouseClicked(evt);
            }
        });
        sekundy.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                sekundyActionPerformed(evt);
            }
        });

        setne.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        setne.setText("000");
        setne.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                setneMouseClicked(evt);
            }
        });
        setne.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                setneActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Dialog", 0, 18)); // NOI18N
        jLabel1.setText("Napi Modyfikator");

        jLabel2.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        jLabel2.setText("Wybierz plik z napisami.srt :");

        importuj.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        importuj.setText("Znajdź plik");
        importuj.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                importujActionPerformed(evt);
            }
        });

        start.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        start.setText("START");
        start.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                startActionPerformed(evt);
            }
        });

        koniec.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N

        sciezka_import.setEditable(false);

        kompen.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        kompen.setText("0");
        kompen.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                kompenMouseClicked(evt);
            }
        });

        jLabel3.setText("Korekta zmiany wyświetlania co napis (ms):");

        jLabel4.setText("Liczba sekund:");

        jLabel5.setText("Liczba milisekund (tysięcznych sekundy):");

        jLabel6.setFont(new java.awt.Font("Dialog", 0, 12)); // NOI18N
        jLabel6.setText("Wybór operacji:");

        przyspiesz.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        przyspiesz.setText("Do przodu");
        przyspiesz.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                przyspieszActionPerformed(evt);
            }
        });

        zwolnij.setFont(new java.awt.Font("Dialog", 0, 14)); // NOI18N
        zwolnij.setText("Do tyłu");
        zwolnij.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                zwolnijActionPerformed(evt);
            }
        });

        jLabel7.setText("Format: \"nnn\"");

        kor_p.setText("Przyspiesz");
        kor_p.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                kor_pActionPerformed(evt);
            }
        });

        kor_t.setText("Zwolnij");
        kor_t.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                kor_tActionPerformed(evt);
            }
        });

        exit.setText("Wyjście");
        exit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                exitActionPerformed(evt);
            }
        });

        info.setText("Info");
        info.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                infoActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addGap(43, 43, 43)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(kompen, javax.swing.GroupLayout.PREFERRED_SIZE, 163, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(kor_p)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(kor_t)
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(jLabel3, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addGroup(layout.createSequentialGroup()
                                        .addGap(0, 0, Short.MAX_VALUE)
                                        .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 243, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                            .addComponent(setne, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 163, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addComponent(sekundy, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 163, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addComponent(jLabel4, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 177, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addComponent(jLabel7, javax.swing.GroupLayout.Alignment.LEADING))
                                        .addGap(0, 0, Short.MAX_VALUE)))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 118, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(zwolnij)
                                    .addComponent(przyspiesz)))))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 166, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(109, 109, 109))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(sciezka_import, javax.swing.GroupLayout.PREFERRED_SIZE, 275, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(73, 73, 73))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 213, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(86, 86, 86))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(koniec, javax.swing.GroupLayout.PREFERRED_SIZE, 214, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(76, 76, 76))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(info, javax.swing.GroupLayout.PREFERRED_SIZE, 82, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(importuj, javax.swing.GroupLayout.PREFERRED_SIZE, 159, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(start, javax.swing.GroupLayout.PREFERRED_SIZE, 159, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(exit, javax.swing.GroupLayout.PREFERRED_SIZE, 83, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(28, 28, 28)))))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 18, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(sekundy, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(przyspiesz)
                            .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 15, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(7, 7, 7)
                        .addComponent(zwolnij))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel7)
                        .addGap(2, 2, 2)
                        .addComponent(setne, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(kompen, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(kor_p)
                    .addComponent(kor_t))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(9, 9, 9)
                .addComponent(sciezka_import, javax.swing.GroupLayout.PREFERRED_SIZE, 28, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(importuj, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(34, 34, 34)
                        .addComponent(start, javax.swing.GroupLayout.PREFERRED_SIZE, 43, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(41, 41, 41)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(exit, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(info, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(18, 18, 18)
                .addComponent(koniec, javax.swing.GroupLayout.DEFAULT_SIZE, 20, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void sekundyActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_sekundyActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_sekundyActionPerformed

    private void setneActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_setneActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_setneActionPerformed

    private void importujActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_importujActionPerformed

        JFileChooser fc = new JFileChooser();
        if (fc.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            nazwa = fc.getSelectedFile().getAbsolutePath();
            //System.out.println(nazwa);
            sciezka_import.setText(nazwa);
        }
    }//GEN-LAST:event_importujActionPerformed

    private void startActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_startActionPerformed

        if (!przyspiesz.isSelected() && !zwolnij.isSelected()) {
            JOptionPane.showMessageDialog(null, "Nie wybrano operacji na napisach");
        } else {
            if (nazwa == null || nazwa.length() < 4 || !nazwa.substring(nazwa.length() - 4, nazwa.length()).equals(".srt")) {
                JOptionPane.showMessageDialog(null, "Nie wybrano pliku .srt!");
            } else {
                //koniec.setText("Plik jest modyfikowany. Czekaj...");
                Matcher s = wzor.matcher(sekundy.getText());
                Matcher se = wzor2.matcher(setne.getText());
                Matcher k = wzor.matcher(kompen.getText());
                if (!s.matches() || !se.matches() || !k.matches()) {
                    JOptionPane.showMessageDialog(null, "Niedozwolone znaki lub błędny format!");
                } else {
                    sekund = Integer.parseInt(sekundy.getText());
                    set = Integer.parseInt(setne.getText());
                    kom = Integer.parseInt(kompen.getText());

                    if (zwolnij.isSelected()) {
                        sekund = sekund * -1;
                        set = set * -1;
                    }

                    if (kor_t.isSelected()) {
                        kom = kom * -1;
                    }

                    Napi_projekt_srt.starting();
                    koniec.setText("Zrobione!! Plik zmieniony.");
                }
            }
        }
    }//GEN-LAST:event_startActionPerformed

    private void sekundyMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_sekundyMouseClicked
        sekundy.setText("");
    }//GEN-LAST:event_sekundyMouseClicked

    private void setneMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_setneMouseClicked

        setne.setText("");
    }//GEN-LAST:event_setneMouseClicked

    private void kompenMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_kompenMouseClicked

        kompen.setText("");
    }//GEN-LAST:event_kompenMouseClicked

    private void przyspieszActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_przyspieszActionPerformed
        if (!przyspiesz.isSelected()) {
            przyspiesz.setSelected(true);
        }
        if (zwolnij.isSelected()) {
            zwolnij.setSelected(false);
        }
    }//GEN-LAST:event_przyspieszActionPerformed

    private void zwolnijActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_zwolnijActionPerformed
        if (!zwolnij.isSelected()) {
            zwolnij.setSelected(true);
        }
        if (przyspiesz.isSelected()) {
            przyspiesz.setSelected(false);
        }

    }//GEN-LAST:event_zwolnijActionPerformed

    private void kor_pActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_kor_pActionPerformed
        if (!kor_p.isSelected()) {
            kor_p.setSelected(true);
        }
        if (kor_t.isSelected()) {
            kor_t.setSelected(false);
        }
    }//GEN-LAST:event_kor_pActionPerformed

    private void kor_tActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_kor_tActionPerformed
        if (!kor_t.isSelected()) {
            kor_t.setSelected(true);
        }
        if (kor_p.isSelected()) {
            kor_p.setSelected(false);
        }
    }//GEN-LAST:event_kor_tActionPerformed

    private void exitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_exitActionPerformed
        System.exit(0);
    }//GEN-LAST:event_exitActionPerformed

    private void infoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_infoActionPerformed
        JFrame informacja = new JFrame("Informacja o programie");
        informacja.setSize(500, 300);
        informacja.setLocationRelativeTo(null);
        informacja.setVisible(true);
        informacja.add(new TextArea("Ten program powstał w celu modyfikowania źle dobranych napisów."));
    }//GEN-LAST:event_infoActionPerformed

    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Okno.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Okno.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Okno.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Okno.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Okno().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton exit;
    private javax.swing.JButton importuj;
    private javax.swing.JButton info;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JTextField kompen;
    private javax.swing.JLabel koniec;
    private javax.swing.JRadioButton kor_p;
    private javax.swing.JRadioButton kor_t;
    private javax.swing.JRadioButton przyspiesz;
    private javax.swing.JTextField sciezka_import;
    private javax.swing.JTextField sekundy;
    private javax.swing.JTextField setne;
    private javax.swing.JButton start;
    private javax.swing.JRadioButton zwolnij;
    // End of variables declaration//GEN-END:variables

}
