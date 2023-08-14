from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# def stop_program(e):
#     print("Program stopped by user.")
#     global stop_flag
#     stop_flag = True

driver = webdriver.Firefox()

url = "http://studykanji.net/kanjiflashcards/chrome"
driver.get(url)

max_wait_time = 10
stop_flag = False

# keyboard.on_press_key("s", stop_program)
kanji_output_file = "question.txt"
english_output_file = "answer.txt"
kana_output_file = "answer2.txt"
counter = 1

input("Perform manual steps and press Enter when done...")

with open(kanji_output_file, "a") as file1, open(
    english_output_file, "a"
) as file2, open(kana_output_file, "a") as file3:
    while not stop_flag:
        answer_button = WebDriverWait(driver, max_wait_time).until(
            EC.visibility_of_element_located((By.XPATH, "//input[@id='show-answer']"))
        )

        answer_button.click()

        correct_button = WebDriverWait(driver, max_wait_time).until(
            EC.visibility_of_element_located((By.XPATH, "//input[@id='correct']"))
        )
        kana_text = WebDriverWait(driver, max_wait_time).until(
            EC.visibility_of_element_located((By.XPATH, "//span[@id='hiragana2']"))
        )
        english_text = WebDriverWait(driver, max_wait_time).until(
            EC.visibility_of_element_located((By.XPATH, "//span[@id='english']"))
        )
        kanji_text = WebDriverWait(driver, max_wait_time).until(
            EC.visibility_of_element_located((By.XPATH, "//span[@id='kanji-text']"))
        )

        kana_text_parts = kana_text.text.split("  -")[0]
        english_text_content = english_text.text.lower()
        kanji_text_content = kanji_text.text
        print(kanji_text_content)
        correct_button.click()

        file1.write(kanji_text_content + " (" + kana_text_parts + ")" "\n")
        file2.write(english_text_content + "\n")

        if counter % 25 == 0:
            file1.write("\n")
            file2.write("\n")
            # file3.write("\n")
        # file3.write(kana_text_parts + "\n")
        counter += 1

driver.quit()
