using HudSystem;

namespace InGameMenuModule
{
	public class InGameSliderItem
	{
		public UISliderHierarchy sliderHierarchy;

		private float minValue_;

		private float maxValue_;

		private readonly bool reversed_;

		private readonly bool usePercentValue_;

		private float sliderStep = 0.05f;

		private float fullRange
		{
			get
			{
				return maxValue_ - minValue_;
			}
		}

		public float CurrentSliderValue
		{
			get
			{
				return (!reversed_) ? (sliderHierarchy.slider.value * fullRange + minValue_) : (fullRange - sliderHierarchy.slider.value * fullRange + minValue_);
			}
			set
			{
				sliderHierarchy.slider.value = ((!reversed_) ? ((value - minValue_) / fullRange) : (1f - (value - minValue_) / fullRange));
			}
		}

		public InGameSliderItem(string title, UISliderHierarchy sliderHierarchy, float minValue, float maxValue, ButtonSetGroup group, bool usePercentValue = false, bool reversed = false)
		{
			sliderHierarchy.descriptionLabel.text = title;
			minValue_ = minValue;
			maxValue_ = maxValue;
			this.sliderHierarchy = sliderHierarchy;
			reversed_ = reversed;
			usePercentValue_ = usePercentValue;
			ButtonSet.Up(sliderHierarchy.minusButton, OnMinusClick, group);
			ButtonSet.Up(sliderHierarchy.plusButton, OnPlusClick, group);
			EventDelegate.Set(sliderHierarchy.slider.onChange, OnSliderValueChanged);
		}

		private void OnSliderValueChanged()
		{
			if (usePercentValue_)
			{
				sliderHierarchy.valueLabel.SetCurrentPercent();
				return;
			}
			float num = sliderHierarchy.slider.value * fullRange + minValue_;
			sliderHierarchy.valueLabel.text = ((int)num).ToString();
		}

		private void OnPlusClick()
		{
			if (sliderHierarchy.slider.value + sliderStep > 1f)
			{
				sliderHierarchy.slider.value = 1f;
			}
			else
			{
				sliderHierarchy.slider.value += sliderStep;
			}
		}

		private void OnMinusClick()
		{
			if (sliderHierarchy.slider.value - sliderStep < 0f)
			{
				sliderHierarchy.slider.value = 0f;
			}
			else
			{
				sliderHierarchy.slider.value -= sliderStep;
			}
		}
	}
}
