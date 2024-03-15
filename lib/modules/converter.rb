module Converter

  # @volumes = %w(gal qrt pint cup tbsp tsp fl_oz ml)

  @volumes = {}
  v_names = {
    gal: %w(gal Gal GAL gall Gall gallon Gallon g G ),
    qrt: %w(qrt Qrt QRT qaurt Quart q Q),
    pint: %w(pint Pint PINT p P pt PT),
    cup: %w(cup Cup c C cups Cups),
    tbsp: %w(tbsp TBSP tbsps TBSPs tablespoon Tablespoon tablespoons Tablespoons),
    tsp: %w(tsp TSP tsps TSPS teaspoon Teaspoon teaspoons Teaspoons),
    fl_oz: ['fl_oz', 'FL_OZ', 'fluid ounce', 'Fluid Ounce', 'fl oz', 'FL OZ'],
    ml: %w(ml ML milliter Millitter mls MLS millitters Millitters)
  }
  v_names.each { |k , v| @volumes[v] = k.to_s }

    # @weight = %w(lb oz g)
  @base_v_msr = 'ml'
    # @base_w_msr = 'g'

  @vol_msr = @volumes.values.each_with_index.map { |n, i| [n, i] }.to_h

  @v_formulas = {
    '0': [1, 4, 8, 16, 256, 768, 128, 3785.4],
    '1': [0.25, 1, 2, 4, 64, 192, 32, 950],
    '2': [0.125, 0.5, 1, 2, 32, 96, 16, 470],
    '3': [0.0625, 0.25, 0.5, 1, 16, 48, 8, 240],
    '4': [0.00391, 0.01563, 0.03125, 0.0625, 1, 3, 0.5, 15],
    '5': [0.0013, 0.00521, 0.01042, 0.02083, 0.33333, 1, 0.16667, 5],
    '6': [0.00781, 0.03125, 0.0625, 0.125, 2, 6, 1, 30],
    '7': [0.00026, 0.00105, 0.00213, 0.00417, 0.06667, 0.2, 0.03333, 1]
  }

  def self.set_v_msr(attr = {})
    measure = attr[:m]
    base_v = ''
    msr_ing = measure.to_s.downcase.singularize
    @volumes.each { |k, v| k.include?(msr_ing) ? base_v = v.to_s : "0" }
    base_v
  end

  def self.v_to_base_v(attr = {})
    m = attr[:m]
    q = attr[:q]
    msr_from = @vol_msr[m].to_s.to_sym
    msr_to = @vol_msr[@base_v_msr]
    multiplier = @v_formulas[msr_from][msr_to]
    base_v_q = multiplier * q
    { q: base_v_q, m: @base_v_msr }
  end
end
