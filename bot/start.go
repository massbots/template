package bot

import (
	tele "gopkg.in/telebot.v3"
)

func (b Bot) onStart(c tele.Context) error {
	return c.Send(
		b.Text(c, "start"),
		b.Markup(c, "menu"),
		tele.NoPreview,
	)
}